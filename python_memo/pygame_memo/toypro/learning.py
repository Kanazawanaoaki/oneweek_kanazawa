#!/usr/bin/env python
# -*- coding: utf-8 -*-
import numpy as np
import torch
import torchvision
import os, signal, sys
import argparse
import multiprocessing
import sys
import pygame
import torch.multiprocessing
from torchsummary import summary
from std_msgs.msg import Float64MultiArray, Float64
from train import WashSystem
from inference import Inference
from main import Game
sys.path.append('.')
from dataset import MyDataset
#sharing_strategy = 'file_system' 
#torch.multiprocessing.set_sharing_strategy(sharing_strategy)

if __name__ == '__main__':
    signal.signal(signal.SIGINT, lambda signal, frame: sys.exit(0))

    # init arg parser
    parser = argparse.ArgumentParser()
    parser.add_argument("--train", "-tr", nargs='?', default=True, const=True, help="train NN 1 or 0")
    parser.add_argument("--test", "-te", nargs='?', default=False, const=False, help="test NN 1 or 0")
    parser.add_argument("--action", "-a", default=2, help="0:simulate 1:realtime feedback with simulate 2:realtime feedback with real robot")
    parser.add_argument("--model", "-m", default='model_hoge.pth', help="which model do you use")
    parser.add_argument("--online_training", "-o", nargs='?', default=False, const=True, help="online training")                
    parser.add_argument("--file_name", "-p", default="hoge", help="file path")
    parser.add_argument("--case", "-c", default=0, help="game case 1 or 0")
    args = parser.parse_args()

    # parse
    train_flag = int(args.train)   # parse train
    test_flag = int(args.test)   # parse train
    action = int(args.action)   # parse action
    model_file = args.model   # which model
    online_training_ = args.online_training   # which model
    file_name = args.file_name
    case_flag = int(args.case)
    
    ws = WashSystem()
    
    # train model or load model
    if train_flag:
        datasets = MyDataset(file_name)
        train_dataloader = ws.load_data(datasets)
        #ws.arrange_data()
        ws.make_model()
        print('[Train] start')        
        ws.train(train_dataloader)
        ws.save_model()
    else:
        model_file_path = ws.model_folder_name + "model_" + model_file + ".pth"
        model = ws.load_model(model_file_path)
       
    # test
    if test_flag:
        print('[Test] start')            
        inference = Inference()
        inference.test(model, case_flag)
        inference.destruction()

    # action
    #if action == 0:
    #    print('[Simulate] start')
    #    #ws.simulate_offline(simulate_loop_num=300)
    #elif action == 1:
    #    print('[RealtimeFeedback] start with simulate')                
    #    ws.realtime_feedback(simulate=True, online_training=False)
    #elif action == 2:
    #    print('[RealtimeFeedback] start with real robot')                
    #    ws.realtime_feedback(simulate=False, online_training=online_training_)     
