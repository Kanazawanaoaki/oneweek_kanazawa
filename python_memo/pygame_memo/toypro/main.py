import pygame
import datetime
import time
import pickle
import os
import random
import argparse
import numpy as np

from buffer import *
from os.path import expanduser

class DataConfig(object):
    def __init__(self):
        super(DataConfig, self).__init__()
        self.try_num = 100
        self.data_length = 100
        # self.buffer_size = self.try_num * self.data_length / 5 * 3 

class Actor(object):
    def __init__(self):
        super(Actor, self).__init__()
        pass

class Obstacle(object):
    def __init__(self):
        pass
    
class Game(object):
    def __init__(self):
        self.BLACK = (0, 0, 0)
        self.RED = (255, 0, 0)
        self.GREEN = (0, 255, 0)
        self.dang_label = 0
        self.x = 0
        self.y = 0
        self.X = 80
        self.Y = 80
        self.seq_XY = np.zeros((1,2))
        self.seq_xy = np.zeros((1,2))
        self.traj_shape = 2
        self.img_shape = 2
        self.dang_shape = 1
        self.seq_dang = np.zeros((1))
        
        pygame.init()
        self.press = pygame.key.get_pressed()
        self.screen = pygame.display.set_mode((128, 128))
        self.myclock = pygame.time.Clock()

    def save_image(self, folder_name):
        file_name = "/image.png"
        pygame.image.save(self.screen, folder_name + file_name)

    def save_actor_trajectory(self, folder_name):
        file_name = "/actor_trajectory.pkl"
        with open(folder_name + file_name, "wb") as f:
            pickle.dump(self.x, f)

    def save_data(self):
        now = datetime.datetime.now()
        walltime = str(int(time.time()*1000000000))
        folder_name = expanduser('~/Data/wash_dish/toy_problem/') + walltime 
        os.makedirs(folder_name)
        self.save_image(folder_name)
        self.save_actor_trajectory(folder_name)
        self.danger_recognition(folder_name)

    def danger_recognition(self):
        if not\
            (self.press[pygame.K_LEFT] or \
            self.press[pygame.K_RIGHT] or \
            self.press[pygame.K_UP] or \
            self.press[pygame.K_DOWN]):
            self.dang_label = 0 # safe
        else:
            self.dang_label = 1 # danger

    def danger_save(self, danger, folder_name):
        file_name = "/danger.pkl"
        with open(folder_name + file_name, "wb") as g:
            pickle.dump(danger, g)

    def reset(self, test_level):
        self.x = 0
        self.y = 0
        random.seed()
        # normal level
        if test_level == 0:
            self.X = random.randint(40, 120)
            self.Y = random.randint(40, 120)
        # easy level
        if test_level == 1:
            self.X = random.randint(10, 50)
            self.Y = random.randint(90, 120)
        self.seq_XY = np.zeros((1,2))
        self.seq_xy = np.zeros((1,2))
        self.seq_dang = np.zeros((1))

    def obstacle_movement_policy(self, i):
        random.seed()
        x_grad = (((self.x - self.X) \
                // 4 + 1) // 3 + 1) // 2 \
                * (i // 50 + 1)
        y_grad = (((self.y - self.Y) \
                // 4 + 1) // 3 + 1) // 2 \
                * (i // 50 + 1)
        self.X = self.X + random.randint(-3,3) + x_grad #+ key_x // 2
        self.Y = self.Y + random.randint(-3,3) + y_grad #+ key_y // 2

    def agent_movement_policy(self, key_x=0, key_y=0):
        if not (key_x == 0 and key_y == 0) :
            self.x += key_x
            self.y += key_y
            if self.x < 128: 
                self.x += 1
            if self.y < 128:
                self.y += 1
        else:
            if self.x < 128: 
                self.x += 2
            if self.y < 128:
                self.y += 2

    def key_interaction(self, i, test_level):
        self.press = pygame.key.get_pressed()
        key_x = 0
        key_y = 0
        if(self.press[pygame.K_LEFT] and self.x>0): key_x-=2
        if(self.press[pygame.K_RIGHT] and self.x<128): key_x+=2
        if(self.press[pygame.K_UP] and self.y>0): key_y-=2
        if(self.press[pygame.K_DOWN] and self.y<128): key_y+=2

        # save image at time t-1 and save desired point at time t
        # self.save_data()
        self.obstacle_movement_policy(i)
        self.agent_movement_policy(key_x, key_y)

    def post_process(self, i):
        self.screen.fill(self.BLACK)
        pygame.draw.circle(self.screen, self.RED, (self.x, self.y), 5)
        pygame.draw.circle(self.screen, self.GREEN, (self.X, self.Y), 10)

        # judge if reaching goal
        if self.x >= 127 and self.y >= 127:
            return 1
        # judge if collision
        if np.linalg.norm((self.x - self.X, self.y - self.Y)) < (5 + 15) :
            return 2
        #print(pygame.image.tostring(self.screen, "RGB"))
        self.danger_recognition()
        if i == 0:
            self.seq_XY[0] = np.array((self.X, self.Y))
            self.seq_xy[0] = np.array((self.x, self.y))
            self.seq_dang[0] = np.array((self.dang_label))
        else:
            self.seq_XY = np.vstack((self.seq_XY, np.array((self.X, self.Y)).reshape(1, 2)))
            self.seq_xy = np.vstack((self.seq_xy, np.array((self.x, self.y)).reshape(1, 2)))
            self.seq_dang = np.vstack((self.seq_dang, np.array((self.dang_label))))

        # # why this need? tmp comment out
        # if i == data_length - 1:
        #     self.dang_label = 1

        pygame.display.flip()
        self.myclock.tick(30)
        return 0

    def rollout(self, try_num, data_length, test_level, device="cuda"):
        buffer = SimpleBuffer(try_num, data_length, self.traj_shape, self.img_shape, self.dang_shape, device)
        try_count = 0 
        while (try_count != try_num): 
            self.reset(test_level)
            for i in range(data_length):
                for event in pygame.event.get():
                    if event.type == pygame.QUIT: self.dang_label =1

                self.key_interaction(i, test_level)
                is_break = self.post_process(i)
                if is_break:
                    if is_break == 2:
                        fail_label = 1
                    elif is_break == 1:
                        fail_label = 0
                    break
                fail_label = 1

            if fail_label == 1:
                buffer.delete()
                print("Failed!!!")
            else:
                try_count += 1 
                buffer.append(self.seq_xy, self.seq_XY, self.seq_dang)
                print("Succeeded!!! : ", try_count)

        return buffer
    
    def destruction(self):
        pygame.quit()

if __name__ == '__main__':
    # init arg parser
    parser = argparse.ArgumentParser()
    parser.add_argument("--case", "-c", default=0, help="game case 1 or 0")
    args = parser.parse_args()
    test_level = int(args.case)

    game = Game()
    dataconfig = DataConfig()
    try_num = dataconfig.try_num
    data_length = dataconfig.data_length
    # buffer = game.rollout(try_num, data_length, test_level, device="cuda")
    buffer = game.rollout(try_num, data_length, test_level, device="cpu")
    buffer.save(test_level)
    game.destruction()
