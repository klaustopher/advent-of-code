using System;
using System.Collections.Generic;
using System.Text;
using Xunit;

namespace AdventOfCode2019
{
    public class IntCodeMachineTests
    {
        [Fact]
        public void ComputesCorrectResults1()
        {
            IntCodeMachine icm = new IntCodeMachine(new int[] { 1, 0, 0, 0, 99 });
            icm.RunCode();
            Assert.Equal(new int[] { 2, 0, 0, 0, 99 }, icm.Code);
        }

        [Fact]
        public void ComputesCorrectResults2()
        {
            IntCodeMachine icm = new IntCodeMachine(new int[] { 2, 3, 0, 3, 99 });
            icm.RunCode();
            Assert.Equal(new int[] { 2, 3, 0, 6, 99 }, icm.Code);
        }

        [Fact]
        public void ComputesCorrectResults3()
        {
            IntCodeMachine icm = new IntCodeMachine(new int[] { 2, 4, 4, 5, 99, 0 });
            icm.RunCode();
            Assert.Equal(new int[] { 2, 4, 4, 5, 99, 9801 }, icm.Code);
        }

        [Fact]
        public void ComputesCorrectResults4()
        {
            IntCodeMachine icm = new IntCodeMachine(new int[] { 1, 1, 1, 4, 99, 5, 6, 0, 99 });
            icm.RunCode();
            Assert.Equal(new int[] { 30, 1, 1, 4, 2, 5, 6, 0, 99 }, icm.Code);
        }
    }
}
