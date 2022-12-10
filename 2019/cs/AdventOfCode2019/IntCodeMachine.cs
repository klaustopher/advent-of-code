using System;
using System.Collections.Generic;
using System.Text;

namespace AdventOfCode2019
{
    class IntCodeMachine
    {
        private int[] _code;
        private int _pointer;

        public int[] Code
        {
            get => _code;
        }
        public IntCodeMachine(int[] code)
        {
            _code = code;
            _pointer = 0;
        }

        public void RunCode()
        {
            bool done = false;
            int result;

            while (!done)
            {
                int opcode = getMemory(_pointer);
                // Console.WriteLine("Opcode: {0}", opcode);

                switch (opcode)
                {
                    case 1:
                        result = getMemory(getMemory(_pointer + 1)) + getMemory(getMemory(_pointer + 2));
                        writeMemory(getMemory(_pointer + 3), result);

                        _pointer = _pointer + 4;
                        break;
                    case 2:
                        result = getMemory(getMemory(_pointer + 1)) * getMemory(getMemory(_pointer + 2));
                        writeMemory(getMemory(_pointer + 3), result);

                        _pointer = _pointer + 4;
                        break;
                    case 99:
                        done = true;
                        break;
                }
            }
        }

        public int getMemory(int address)
        {
            return _code[address];
        }

        void writeMemory(int address, int value)
        {
            _code[address] = value;
        }

    }
}
