﻿using System;
using System.Collections.Generic;
using System.Text;

namespace AdventOfCode2019
{
    class Day22 : Challenge
    {
        public string findResult()
        {
            int[] input = { 1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,9,19,1,19,5,23,2,6,23,27,1,6,27,31,2,31,9,35,1,35,6,39,1,10,39,43,2,9,43,47,1,5,47,51,2,51,6,55,1,5,55,59,2,13,59,63,1,63,5,67,2,67,13,71,1,71,9,75,1,75,6,79,2,79,6,83,1,83,5,87,2,87,9,91,2,9,91,95,1,5,95,99,2,99,13,103,1,103,5,107,1,2,107,111,1,111,5,0,99,2,14,0,0
 };
            int expectedOutputValue = 19690720;
            IntCodeMachine icm;

            for (int noun = 0; noun <= 99; noun++)
            {
                for (int verb = 0; verb <= 99; verb++)
                {
                    int[] copyOfCode = (int[])input.Clone();
                    copyOfCode[1] = noun;
                    copyOfCode[2] = verb;

                    icm = new IntCodeMachine(copyOfCode);
                    icm.RunCode();
                    if (icm.getMemory(0) == expectedOutputValue)
                    {
                        return (100 * noun + verb).ToString();
                    }
                }
            }

            return "";
        }
    }
}