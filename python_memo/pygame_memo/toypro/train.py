import torch
import datetime
from torch.utils.data import DataLoader
from os.path import expanduser
import torch.nn as nn
from network import Lstm
import torch.optim as optim
import numpy as np
from torch.utils.tensorboard import SummaryWriter

class WashSystem(object):
    def __init__(self):
        # train parameters
        self.DEVICE = "cuda"
        self.LOOP_NUM = 10
        self.time_steps = 5
        self.epoch_num = 1000
        self.mini_batch_size = 5 #batch_size is 2 but want to change seq_size to data_length
        self.input_dim = 5 #same as z_dim? -> no, angle vector and obj point
        self.output_dim = 5
        self.lrlstm = 0.01
        self.beta1 = 0.9
        self.beta2 = 0.999    
        self.decay = 0.01

        # model_path
        now = datetime.datetime.now()   
        self.model_folder_name = expanduser('~/Data/wash_dish/toy_problem/model/') 
        self.lstm_model_path = self.model_folder_name + 'model_' +  now.strftime('%Y%m%d_%H%M%S') + '.pth'
        self.model = nn.Module 
        
    @staticmethod 
    def set_worker_sharing_strategy(worker_id):
        # https://github.com/pytorch/pytorch/issues/11201#issuecomment-895047235
        torch.multiprocessing.set_sharing_strategy(sharing_strategy)

    def load_data(self, datasets):
        train_dataloader = torch.utils.data.DataLoader(
            datasets, 
            batch_size=self.mini_batch_size, 
            shuffle=True,
            num_workers=2, #multiprocessing.cuda_count(), 
            #pin_memory=True,
            drop_last=True,
            #worker_init_fn=self.set_worker_sharing_strategy
        )
        return train_dataloader

    def make_model(self):
        # self.model = Net()
        # self.model = self.model.to(self.DEVICE)
        #self.criterion = nn.BCEWithLogitsLoss()
        self.criterion = nn.MSELoss(reduce='sum')
        # self.train_optimizer = optim.Adam(self.model.parameters(), lr=0.001)
        # #summary(self.model, [(3, 128, 128), (4,)])

        # networks init
        self.lstm = Lstm(inputDim=self.input_dim, hiddenDim=64, outputDim=self.output_dim) #(5,4,5)
        self.lstm_optimizer = optim.Adam(self.lstm.parameters(), \
                lr=self.lrlstm, betas=(self.beta1, self.beta2), weight_decay=0.01)
        # self.lstm.cuda()
        # self.BCE_loss = nn.BCELoss().cuda()
        self.lstm.cuda()
        
    def train(self, train_dataloader):
        """
        Args
            state [float]: center, force 
            control input [float]: desired position
            danger label [bool]: danger_label 

        """
        now = datetime.datetime.now()
        tensorboard_cnt = 0
        torch.backends.cudnn.benchmark = True
        log_dir = 'data/loss/wash_dish/toy_problem/loss_' + now.strftime('%Y%m%d_%H%M%S')

        writer = SummaryWriter(log_dir)

        for epoch in range(self.epoch_num):
            # training
            running_loss = 0.0
            training_accuracy = 0.0
            for i, data in enumerate(train_dataloader, 0):
                #self.lstm_optimizer.zero_grad()  #Should be comment out
                # https://github.com/pytorch/pytorch/issues/11201#issuecomment-486232056
                #data_cp = copy.deepcopy(data)
            # training
                #del data
                c, s, d = data
                c = c.float().to(self.DEVICE)
                s = s.float().to(self.DEVICE)
                d = d.float().to(self.DEVICE)
                if i == 0:
                    pre_c, pre_s, pre_d = c, s, d
                #print(c.shape) #(self.batch_size, seq_len?, try_num)
                #print(s.shape)
                #print(d.shape)
                data_pre = torch.cat((torch.cat((pre_c, pre_s), axis=2), pre_d), axis=2)
                data_pd = self.lstm(data_pre) #shape: (batch_size, data_size:5)
                #data_pd = self.lstm(s) #shape: (batch_size, data_size:5)
                data_gt = torch.cat((torch.cat((c, s), axis=2), d), axis=2)
                #data_gt = s
                
                #print(data_pre[:,50,2:5]) #(batchsize, 3)
                print(data_pd[0,:,0]) #(batchsize, 3)
                print(data_gt[0,:,0])
                print("----")
                loss = self.criterion(data_pd[:,1:99,:], data_gt[:,0:98,:])
                loss.backward()
                self.lstm_optimizer.step()
                running_loss += loss.item()

                #print(data_pd.data[:,2:5].cuda(), data_gt.data[:,59,:].cpu())
                training_accuracy += \
                        np.sum(np.abs((data_pd.data[:,1:99,:].cpu() - data_gt.data[:,0:98,:].cpu()).numpy()) < 0.1)
                writer.add_scalar("Loss/train", loss.detach().item(), tensorboard_cnt) #(epoch + 1) * i)
                if i % 100 == 99: 
                    print('[%d, %5d] loss: %.3f' %
                          (epoch + 1, i + 1, running_loss / 100))
                    running_loss = 0.0
                tensorboard_cnt += 1
                pre_c, pre_s, pre_d = c, s, d

            print('%d loss: %.3f, training_accuracy: %.5f' % (
                epoch + 1, running_loss, training_accuracy))

    def save_model(self):
        # GPU save   
        ## Save only parameter   
        #torch.save(self.lstm.state_dict(), self.lstm_model_path) 
        torch.save(self.lstm.to('cuda').state_dict(), self.lstm_model_path)
        ## Save whole model
        #torch.save(self.model(), lstm_model_path)   
        #torch.save(self.ae(), encoder_model_path)   
        # CPU save  
        #torch.save(self.model.to('cuda').state_dict(), model_path)
        print("Finished Saving model:", self.lstm_model_path)    

    def load_model(self, model_path):
        print('Loading model...')
        self.model = Lstm(inputDim=self.input_dim, hiddenDim=64, outputDim=self.output_dim) #(5,4,5)
        self.model.load_state_dict(torch.load(model_path))
        self.model.eval()
        #summary(self.model, (50, 2+2+1))
        return self.model

