using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace AdventOfCode2019
{
    class Day12 : Challenge
    {
        private int calculateFuel(int mass)
        {
            int fuelMass = ((mass / 3) - 2);
            if (fuelMass <= 0) { return 0; }

            return fuelMass + calculateFuel(fuelMass);
        }
        public string findResult()
        {

            List<int> items = Resources.Day1.Split(System.Environment.NewLine.ToCharArray()).Where(x => !string.IsNullOrEmpty(x)).Select(str => int.Parse(str)).ToList();

            int result = items.Select(mass => calculateFuel(mass)).Sum();


            return result.ToString();
        }
    }
}
