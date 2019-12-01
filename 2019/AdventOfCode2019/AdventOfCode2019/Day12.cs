using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Xunit;

namespace AdventOfCode2019
{
    public class Day12 : Challenge
    {
        private int CalculateFuel(int mass)
        {
            int fuelMass = ((mass / 3) - 2);
            if (fuelMass <= 0) { return 0; }

            return fuelMass + CalculateFuel(fuelMass);
        }

        [Theory]
        [InlineData(14, 2)]
        [InlineData(1969, 966)]
        [InlineData(100756, 50346)]
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
