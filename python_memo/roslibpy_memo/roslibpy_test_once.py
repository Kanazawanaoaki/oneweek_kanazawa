#!/usr/bin/env python
# -*- coding: utf-8 -*-

import time
from roslibpy import Message, Ros, Topic


class rosbridge_client:
    def __init__(self):
        self.ros_client = Ros('localhost', 9090)
        print("wait for server")
        self.publisher = Topic(
            self.ros_client, '/test_cmd_vel', 'geometry_msgs/Twist')

        self.ros_client.run()
        # self.ros_client.on_ready(self.start_thread, run_in_thread=True)
        # print("run forever")
        # self.ros_client.run_forever()

    def pub_topic(self, value):
        self.publisher.publish(Message({
            'linear': {
                'x': value,
                'y': 0,
                'z': 0
            },
            'angular': {
                'x': 0,
                'y': 0,
                'z': value
            }
        }))

    def start_thread(self):
        while True:
            if self.ros_client.is_connected:
                self.publisher.publish(Message({
                    'linear': {
                        'x': 0.5,
                        'y': 0,
                        'z': 0
                    },
                    'angular': {
                        'x': 0,
                        'y': 0,
                        'z': 0.5
                    }
                }))
            else:
                print("Disconnect")
                break
            time.sleep(1.0)


if __name__ == '__main__':
    rc = rosbridge_client()

    for i in range(10):
        print("time {}".format(i))
        rc.pub_topic(0.1 * i)
        time.sleep(1.0)
    rc.publisher.unadvertise()
    rc.ros_client.close()
