using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Xunit;

namespace AdventOfCode2019
{
    public class Day11 : Challenge
    {
        private int CalculateFuel(int mass)
        {
            return ((mass / 3) - 2);
        }

        [Theory]
        [InlineData(12, 2)]
        [InlineData(14, 2)]
        [InlineData(1969, 654)]
        [InlineData(100756, 33583)]
        public void CalculatesCorrectFuelWeight(int mass, int expectedFuelWeight)
        {
            Assert.Equal(expectedFuelWeight, CalculateFuel(mass));
        }

        public string findResult()
        {
            List<int> items = Resources.Day1.Split(System.Environment.NewLine.ToCharArray()).
                Where(x => !string.IsNullOrEmpty(x)).
                Select(str => int.Parse(str)).
                ToList();

            int result = items.Select(mass => CalculateFuel(mass)).Sum();

            return result.ToString();
        }
    }
}
