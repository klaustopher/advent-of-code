using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace AdventOfCode2019
{
    class Day11 : Challenge
    {
        private int calculateFuel(int mass)
        {
            return ((mass / 3) - 2);
        }
        public string findResult()
        {
            List<int> items = Resources.Day1.Split(System.Environment.NewLine.ToCharArray()).
                Where(x => !string.IsNullOrEmpty(x)).
                Select(str => int.Parse(str)).
                ToList();

            int result = items.Select(mass => calculateFuel(mass)).Sum();

            return result.ToString();
        }
    }
}
