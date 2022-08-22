import torch
from os.path import expanduser
from main import DataConfig
from torch.utils.data import Dataset
from buffer import SimpleBuffer

class MyDataset(Dataset, DataConfig):
    def __init__(self, file_path):
        super(MyDataset, self).__init__()
        self.time_steps = 5
        self.batch_size = 5
        self.danger_label = []
        self.control_input = []
        self.state_input = []
        self.window_size = 10 

        self.img_shape = 2 # X,Y(,diameter)
        self.traj_shape = 2
        self.dang_shape = 1
        folder_name = expanduser('~/Data/wash_dish/toy_problem/') 
        traj_path = folder_name + 'traj_' + file_path + '.pth'
        img_path = folder_name + 'image_' + file_path + '.pth'
        dang_path = folder_name + 'dang_' + file_path + '.pth'
        buf = SimpleBuffer(self.try_num, self.data_length, self.traj_shape, self.img_shape, self.dang_shape, device=torch.device('cuda'))
        traj_buffer, img_buffer, dang_buffer = buf.load(traj_path, img_path, dang_path)
        traj_buffer = traj_buffer.to('cpu').detach().numpy().copy()
        img_buffer = img_buffer.to('cpu').detach().numpy().copy()
        dang_buffer = dang_buffer.to('cpu').detach().numpy().copy()
        self.control_input = traj_buffer.reshape(self.try_num, self.data_length, 2)
        self.state_input = img_buffer.reshape(self.try_num, self.data_length, 2)
        self.danger_label = dang_buffer.reshape(self.try_num, self.data_length, 1)
        #data = data_buffer.reshape(self.try_num, data_length, self.traj_shape + self.img_shape + self.dang_shape)

    def __len__(self):
        #return (self.seq_length - self.time_steps) * self.seq_num #/ self.batch_size # len(self.dataset) - self.time_steps  (30-5)/2*4=50 
        return self.try_num / self.batch_size #25 #50/2
        # return (self.data_length - self.window) * self.try_num / self.batch_size #25 #50/2
        # return self.data_length // self.window_size

    def __getitem__(self, idx):
        # idx = idx * self.window_size
        # print('window: {}-{}'.format(idx, idx+self.window_size-1))
        # for i in range(0, self.window_size):
        #     self.control_input[i] = torch.tensor(self.control_input[idx+i])
        #     self.state_input[i] = torch.tensor(self.state_input[idx+i])
        #     self.danger_label[i] = torch.tensor(self.danger_label[idx+i])
        # return self.control_input, self.state_input,self.danger_label

        return  self.control_input[idx], self.state_input[idx], self.danger_label[idx]
        # return  self.control_input[idx:idx+self.window_size], \
        #         self.state_input[idx:idx+self.window_size], \
        #         self.danger_label[idx:idx+self.window_size]
        

