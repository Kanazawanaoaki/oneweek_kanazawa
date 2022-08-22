#!/usr/bin/env python
# -*- coding: utf-8 -*-

import torch
import os 
import datetime
import numpy as np

from os.path import expanduser
from tensorflow.keras.preprocessing.sequence import pad_sequences


class SimpleBuffer:
    def __init__(self, try_num, data_length, traj_shape, img_shape, dang_shape, device=torch.device('cuda')):
        # GPU上に保存するデータ．
        self.trajs = torch.empty((try_num, data_length, traj_shape), dtype=torch.float, device=device)
        self.imgs = torch.empty((try_num, data_length, img_shape), dtype=torch.float, device=device)
        self.dangs = torch.empty((try_num, data_length, dang_shape), dtype=torch.float, device=device)
        # 次にデータを挿入するインデックス．
        self._p = 0
        self.data_length = data_length
        #self.buffer_size = buffer_size
        self.max_length = data_length
        self.device = device

    def append(self, traj, img, dang):
        self.trajs[self._p,:,:] = torch.from_numpy(pad_sequences([traj], padding='post', maxlen=self.max_length)[0])
        self.imgs[self._p,:,:] = torch.from_numpy(pad_sequences([img], padding='post', maxlen=self.max_length)[0])
        self.dangs[self._p,:,:] = torch.from_numpy(pad_sequences([dang], padding='post', maxlen=self.max_length)[0])
        self._p = (self._p + 1) #% self.data_length

    def save(self, case_flag):
        """
        torch.save({
            'state': self.states.clone().cpu(),
        }, path)
        """
        now = datetime.datetime.now()  
        folder_name = expanduser('~/Data/wash_dish/toy_problem/') 
        time_case_pth = now.strftime('%Y%m%d_%H%M%S') + '_' + str(case_flag) + '.pth'
        print("file_name", time_case_pth)
        traj_path = folder_name + 'traj_' + time_case_pth
        img_path = folder_name + 'image_' + time_case_pth
        dang_path = folder_name + 'dang_' + time_case_pth
        # GPU save
        ## Save whole model
        torch.save(self.trajs, traj_path)
        torch.save(self.imgs, img_path)
        torch.save(self.dangs, dang_path)
        # CPU save
        #torch.save(self.model.to('cpu').state_dict(), model_path)
 
    def get(self):
        assert self._p == 0, 'Buffer needs to be full before training.'
        return self.trajs, self.imgs, self.dangs

    def delete(self):
        self._p = self._p #- self.data_length
 
    # path should be set by parser
    def load(self, traj_path, img_path, dang_path):
        # learn GPU, load GPU
        traj = torch.load(traj_path)
        img = torch.load(img_path)
        dang = torch.load(dang_path)
        # learn CPU, load GPU
        #self.model.load_state_dict(torch.load(path, map_location=torch.device('cpu')))
        return traj, img, dang
