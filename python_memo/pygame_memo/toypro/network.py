#!/usr/bin/env python
# -*- coding: utf-8 -*-
import torch
from torch.distributions import Normal
from torch.distributions.kl import kl_divergence
from torch import nn
from torch.nn import functional as F

def initialize_weights(net):
    for m in net.modules():
        if isinstance(m, nn.Conv2d):
            m.weight.data.normal_(0, 0.02)
            m.bias.data.zero_()
        elif isinstance(m, nn.ConvTranspose2d):
            m.weight.data.normal_(0, 0.02)
            m.bias.data.zero_()
        elif isinstance(m, nn.Linear):
            m.weight.data.normal_(0, 0.02)
            m.bias.data.zero_()

class Lstm(nn.Module):
    """
    inputDim : 5
    hiddenDim : any number is ok?
    outputDim : same as imputDim? or only robot state dim?
    """
    def __init__(self, inputDim, hiddenDim, outputDim):
        super(Lstm, self).__init__()
        self.rnn = nn.LSTM(input_size = inputDim,
                            hidden_size = hiddenDim,
                            batch_first = True)
        self.output_layer = nn.Linear(hiddenDim, outputDim)

    def forward(self, inputs, hidden0=None):
        output, (hidden, cell) = self.rnn(inputs, hidden0) #LSTM
        # print(output.shape) #(5,60,4) batch, time_len,  hidden
        # print(output[:, -1, :].shape) #(5,4) get last seq data
        # print(hidden.shape) #(1,5,4) 
        # print(cell.shape) #(1,5,4)
        output = self.output_layer(output[:, :, :]) #fc
        # print(output.shape) #(5,5)
        return output

class generator(nn.Module):
    def __init__(self, input_dim=100, output_dim=1, input_size=32):
        super(generator, self).__init__()
        self.input_dim = input_dim
        self.output_dim = output_dim
        self.input_size = input_size

        self.fc = nn.Sequential(
            nn.Linear(self.input_dim, 1024),
            nn.BatchNorm1d(1024),
            nn.ReLU(),
            nn.Linear(1024, 128 * (self.input_size // 4) * (self.input_size // 4)),
            nn.BatchNorm1d(128 * (self.input_size // 4) * (self.input_size // 4)),
            nn.ReLU(),
        )
        self.deconv = nn.Sequential(
            nn.ConvTranspose2d(128, 64, 4, 2, 1),
            nn.BatchNorm2d(64),
            nn.ReLU(),
            nn.ConvTranspose2d(64, self.output_dim, 4, 2, 1),
            nn.Tanh(),
        )
        initialize_weights(self)

    def forward(self, input):
        x = self.fc(input)
        x = x.view(-1, 128, (self.input_size // 4), (self.input_size // 4))
        x = self.deconv(x)

        return x

class Discriminator(nn.Module):
    def __init__(self, input_dim=1, output_dim=1, input_size=32):
        super(Discriminator, self).__init__()
        self.input_dim = input_dim 
        self.output_dim = output_dim
        self.input_size = input_size
        
        self.fc = nn.Sequential(
            #nn.Linear(1140, 512),    
            #nn.BatchNorm1d(512),
            #nn.LeakyReLU(0.2),
            #nn.Linear(512, self.output_dim),
            nn.Linear(24, self.output_dim),
            nn.Sigmoid(),
                )
        initialize_weights(self)

    def forward(self, input):
        input = input.reshape(2, 24) #To do it is tmp.
        x = input.view(-1, self.num_flat_features(input))
        x = self.fc(x)
        return x

    def num_flat_features(self, x):
        size = x.size()[1:]  # all dimensions except the batch dimension
        num_features = 1
        for s in size:
            num_features *= s
        return num_features

class discriminator(nn.Module):
    def __init__(self, input_dim=1, output_dim=1, input_size=32):
        super(discriminator, self).__init__()
        self.input_dim = input_dim
        self.output_dim = output_dim
        self.input_size = input_size

        self.conv = nn.Sequential(
            nn.Conv2d(self.input_dim, 64, 4, 2, 1),
            nn.LeakyReLU(0.2),
            nn.Conv2d(64, 128, 4, 2, 1),
            nn.BatchNorm2d(128),
            nn.LeakyReLU(0.2),
        )
        self.fc = nn.Sequential(
            nn.Linear(128 * (self.input_size // 4) * (self.input_size // 4), 1024),
            nn.BatchNorm1d(1024),
            nn.LeakyReLU(0.2),
            nn.Linear(1024, self.output_dim),
            nn.Sigmoid(),
        )
        initialize_weights(self)

    def forward(self, input):
        x = self.conv(input)
        x = x.view(-1, 128 * (self.input_size // 4) * (self.input_size // 4))
        x = self.fc(x)

        return x

class Net(nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        """
        This imitates alexnet. 
        self.conv1 = nn.Conv2d(1, 96, kernel_size=11, stride=4, padding=2) #入力チャンネル数は1, 出力チャンネル数は96 
        self.conv2 = nn.Conv2d(96, 256, kernel_size=5, padding=2)
        self.conv3 = nn.Conv2d(256, 384, kernel_size=3, padding=1)
        self.conv4 = nn.Conv2d(384, 384, kernel_size=3, padding=1)
        self.conv5 = nn.Conv2d(384, 256, kernel_size=3, padding=1)
        #self.fc1 = nn.Linear(256 * 6 * 6, 4096)
        self.fc1 = nn.Linear(50176, 4096)
        self.fc2 = nn.Linear(4096, 4096)
        self.fc3 = nn.Linear(4096, 10)
        self.fc4 = nn.Linear(10 + 4, 14)
        self.fc5 = nn.Linear(14, 1) # output is 1 dim scalar probability
        """
        self.conv1 = nn.Conv2d(3, 4, 3, 2, 1)
        self.cbn1 = nn.BatchNorm2d(4)
        self.conv2 = nn.Conv2d(4, 8, 3, 2, 1)
        self.cbn2 = nn.BatchNorm2d(8)
        state_point_key = "obj_point.yaml"
        self.conv3 = nn.Conv2d(8, 16, 3, 2, 1)
        self.cbn3 = nn.BatchNorm2d(16)
        self.conv4 = nn.Conv2d(16, 32, 3, 2, 1)
        self.cbn4 = nn.BatchNorm2d(32)
        self.conv5 = nn.Conv2d(32, 64, 3, 2, 1)
        self.cbn5 = nn.BatchNorm2d(64)
        self.fc1 = nn.Linear(256, 128)
        self.fc2 = nn.Linear(128, 64)
        self.fc3 = nn.Linear(64, 16)
        self.fc4 = nn.Linear(16, 8)
        self.fc5 = nn.Linear(8 + 4, 12)
        self.fc6 = nn.Linear(12, 1) # output is 1 dim scalar probability
        """
        self.conv1 = nn.Conv2d(1, 4, 3, 2, 1)
        self.cbn1 = nn.BatchNorm2d(4)
        self.conv2 = nn.Conv2d(4, 8, 3, 2, 1)
        self.cbn2 = nn.BatchNorm2d(8)
        self.conv3 = nn.Conv2d(8, 16, 3, 2, 1)
        self.cbn3 = nn.BatchNorm2d(16)
        self.conv4 = nn.Conv2d(16, 32, 3, 2, 1)
        self.cbn4 = nn.BatchNorm2d(32)
        #self.conv5 = nn.Conv2d(32, 64, 3, 2, 1)
        #self.cbn5 = nn.BatchNorm2d(64)
        #self.fc1 = nn.Linear(128, 64)
        self.fc1 = nn.Linear(256, 64)
        self.fc2 = nn.Linear(64, 16)
        self.fc3 = nn.Linear(16, 8)
        self.fc4 = nn.Linear(8 + 4, 12)
        self.fc5 = nn.Linear(12, 1) # output is 1 dim scalar probability
        """

    # depth encording without concate grasp point
    def forward(self, x, y):
        x = F.max_pool2d(F.relu(self.conv1(x)), 2)
        x = self.cbn1(x)
        #x = F.max_pool2d(F.relu(self.conv2(x)), 2)
        x = F.relu(self.conv2(x))
        x = self.cbn2(x)
        x = F.relu(self.conv3(x))
        x = self.cbn3(x)
        x = F.relu(self.conv4(x))
        x = self.cbn4(x)
        x = F.relu(self.conv5(x))
        x = self.cbn5(x)
        x = x.view(-1, self.num_flat_features(x))
        #depth_data =depth_data.view(depth_data.shape[0], -1)
        x = F.relu(self.fc1(x))
        x = F.relu(self.fc2(x))
        x = F.relu(self.fc3(x))
        x = F.relu(self.fc4(x))
        z = torch.cat((x, y), dim=1)
        z = F.relu(self.fc5(z))
        z = self.fc6(z)
        """
        x = F.max_pool2d(F.relu(self.conv1(x)), 2)
        x = self.cbn1(x)
        x = F.max_pool2d(F.relu(self.conv2(x)), 2)
        x = self.cbn2(x)
        x = F.relu(self.conv3(x))
        x = self.cbn3(x)
        #x = F.relu(self.conv4(x))
        #x = self.cbn4(x)
        #x = F.relu(self.conv5(x))
        #x = self.cbn5(x)
        x = x.view(-1, self.num_flat_features(x))
        #depth_data =depth_data.view(depth_data.shape[0], -1)
        x = F.relu(self.fc1(x))
        x = F.relu(self.fc2(x))
        x = F.relu(self.fc3(x))
        z = torch.cat((x, y), dim=1)
        z = F.relu(self.fc4(z))
        z = self.fc5(z)
        """
        return z
   
    def num_flat_features(self, x):
        size = x.size()[1:]  # all dimensions except the batch dimension
        num_features = 1
        for s in size:
            num_features *= s
        return num_features


