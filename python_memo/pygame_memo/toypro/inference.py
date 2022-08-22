# -*- coding: utf-8 -*-
import torch
import numpy as np
import pygame 
import random
import copy
from main import Game
from train import WashSystem

class Inference(Game, WashSystem):
    def __init__(self):
        #super(Inference, self).__init__()
        Game.__init__(self)
        WashSystem.__init__(self)

    def test_post_process(self):
        if (128 <= self.x and self.x <= 133) and (128 <= self.y and self.y <= 133):
            print("goal")
            break_flag = 1
        else:
            break_flag = 0
        self.screen.fill(self.BLACK)
        pygame.draw.circle(self.screen, self.RED, (self.x, self.y), 5)
        pygame.draw.circle(self.screen, self.GREEN, (self.X, self.Y), 10)
        pygame.display.flip()
        self.myclock.tick(10)
        return break_flag

    def to_tensor(self):
        self.x = torch.tensor(self.x, dtype=torch.float)
        self.y = torch.tensor(self.y, dtype=torch.float)
        self.X = torch.tensor(self.X, dtype=torch.float)
        self.Y = torch.tensor(self.Y, dtype=torch.float)
        self.dang_label = torch.tensor(self.dang_label, dtype=torch.float) 

    def atractor(self):
        """
        goal oriented vector from current position to next position

        """
        pass

    def test(self, model, case_flag):
        test_count = 0
        while (test_count != 5):
            self.reset(test_level=1)
            self.to_tensor()
            test_input = torch.tensor([0.0 ,0.0, 0.0, 0.0, 0.0]).reshape(1,5)
            for i in range(128):
                for event in pygame.event.get():
                    if event.type == pygame.QUIT: self.flag = 1
                self.model = model
                self.agent_movement_policy()
                self.obstacle_movement_policy(i)
                # model shape: (batch size, seq length, data dimention)
                #test_input = torch.tensor(np.vstack((test_input, np.array([self.x, self.y, self.X, self.Y, dang_label.detach().numpy()]))))
                test_input = torch.tensor(torch.cat((test_input, torch.tensor([self.x, self.y, self.X, self.Y, self.dang_label]).reshape(1,5)), 0))
                test_input = test_input.reshape(test_input.shape[0],test_input.shape[1]).float()
                input_x = torch.tensor(test_input[:,0], requires_grad=True).reshape(-1,1)
                input_y = torch.tensor(test_input[:,1], requires_grad=True).reshape(-1,1)
                input_X = torch.Tensor(test_input[:,2]).reshape(-1,1)
                input_Y = torch.Tensor(test_input[:,3]).reshape(-1,1)
                input_d = torch.tensor(test_input[:,4], requires_grad=True).reshape(-1,1)
                input = torch.cat([input_x, input_y, input_X, input_Y, input_d], dim=1).unsqueeze(0)
                # inference
                test_next = self.model(input)
                next_data = test_next[0]
                next_x, next_y, next_X, next_Y, next_dang_label = next_data[-1]

                # adj next x, y
                if next_x < 0:
                    next_x = 0
                if next_y < 0:
                    next_y = 0
                if abs(next_x - input_x[-1]) > 5:
                    next_x = 5
                if abs(next_y - input_y[-1]) > 5:
                    next_y = 5
                self.make_model()
                input_x.retain_grad()
                input_y.retain_grad()

                if next_x > next_y:
                    next_x_gt = i**(1.01)
                    next_y_gt = i**(1.1)
                else:
                    next_x_gt = i**(1.01)
                    next_y_gt = i**(1.1)
                loss_s = self.criterion(test_next[0,-1,0:2], torch.Tensor([next_x_gt, next_y_gt]))
                loss_s_x = self.criterion(test_next[0,-1,0], torch.Tensor([next_x_gt]))
                loss_s_y = self.criterion(test_next[0,-1,1], torch.Tensor([next_y_gt]))
                loss_s_xy = loss_s_x + loss_s_y
                # danger loss at t+1. dang=0, safe=1 
                loss_d = self.criterion(test_next[0,-1,4], torch.tensor([0.0]))
                print("loss xy", loss_s_xy)
                print("loss d", loss_d)
                if torch.isinf(loss_d) or (loss_d > 1.0e+10):
                    print("loss",loss_d)
                    try:
                        model = prev_model
                        self.lstm_optimizer = torch.optim.Adam(model.parameters()) 
                        self.lstm_optimizer.load_state_dict(prev_optimizer.state_dict())
                    except:
                        pass
                else:
                    prev_model = copy.deepcopy(model)
                    prev_optimizer = copy.deepcopy(self.lstm_optimizer)

                    # initial policy vs predict policy by predicted danger label
                    if case_flag == 0:
                        if next_dang_label < 0:
                            next_dang_label = 0
                        elif next_dang_label > 1:
                            next_dang_label = 1
                        next_x = next_x * next_dang_label + (i + 1) * (1 - next_dang_label)
                        next_y = next_y * next_dang_label + (i + 1) * (1 - next_dang_label)

                    # Switching policy
                    elif case_flag == 1:
                        self.lstm_optimizer.zero_grad()
                        print("next dang", next_dang_label)
                        delta = 1
                        if next_dang_label >= 0.5:
                            loss_d.backward()
                        elif next_dang_label < 0.5:
                            loss_s_xy.backward()
                        self.lstm_optimizer.step()
                        next_x = next_x - delta * input_x.grad[-1]
                        next_y = next_y - delta * input_y.grad[-1]

                    # constant state and danger loss BP
                    elif case_flag == 2:
                        # danger and state loss
                        s_delta = 0.3
                        d_delta = 0.0 #0.1
                        loss = loss_s_xy * s_delta + loss_d * d_delta
                        self.lstm_optimizer.zero_grad()
                        loss.backward()
                        print(loss)
                        self.lstm_optimizer.step()
                        gamma = 100.0
                        print("input_x.grad", (input_x.grad[-1] / sum(input_x.grad)))
                        print("input_y.grad", (input_y.grad[-1] / sum(input_y.grad)))
                        next_x = next_x - gamma * (input_x.grad[-1] / sum(input_x.grad))
                        next_y = next_y - gamma * (input_y.grad[-1] / sum(input_y.grad))
                    else:
                        print("no BP")

                    if self.x - 5 < next_x:
                        if next_x <= 128: 
                            self.x = next_x
                        else:
                            self.x = 128
                    if self.y - 5 < next_y:
                        if next_y <= 128: 
                            self.y = next_y
                        else:
                            self.y = 128
                print("next_x", next_x)
                print("next_y", next_y)
                print("self.x", self.x)
                print("self.y", self.y)
                self.dang_label = next_dang_label
                #print("next dang", self.dang_label) #value should be within 0 to 1 though...
                if (self.test_post_process()):
                    break
            test_count += 1

        # for data in self:
        #     depth_data, grasp_point, labels = data
        #     outputs = self.model(depth_data, grasp_point)
        #     # lossのgrasp_point偏微分に対してoptimaizationする．
        #     depth_data.requires_grad(False)
        #     grasp_point.requires_grad(True)
        #     loss = self.criterion(outputs.view_as(labels), labels)
        #     loss.backward()
        #     self.train_optimizer.step()       

