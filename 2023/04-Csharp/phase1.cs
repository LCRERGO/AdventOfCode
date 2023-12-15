using System;
using System.IO;
using System.Text;
using System.Collections.Generic;


class Program {
    static string FlatSpace(string s)  {
        var retBuilder = new StringBuilder();

        for (int i = 0; i < s.Length; i++) {
            retBuilder.Append(s[i]);

            if (s[i] == ' ') {
                do {
                    i++;
                } while (!Char.IsDigit(s[i]));
                i--;
            }
        }

        return retBuilder.ToString();
    }

    static void Solve(string[] args) {
        string[] lines = File.ReadAllLines(args[0]);

        int sum, total = 0;

        // Process Line start
        foreach (var line in lines) {
            var winning = new List<int>();
            var taken = new List<int>();
            var head = line.Split(':')[0];
            var tail = line.Split(':')[1];

            var cardID = Int32.Parse(FlatSpace(head.Trim(':')).Split()[1].Trim());
            //Console.WriteLine(cardID);
            var numbers = tail.Split('|');
            var winningNums = numbers[0].Trim();
            var takenNums = numbers[1].Trim().Trim('|');
            //Console.WriteLine(winningNums);
            //Console.WriteLine(takenNums);

            foreach (var num in FlatSpace(winningNums).Split()) {
                winning.Add(Int32.Parse(num));
            }


            foreach (var num in FlatSpace(takenNums).Split()) {
                taken.Add(Int32.Parse(num));
            }

            sum = 0;
            foreach (var num in taken) {
                if (winning.Contains(num)) {
                    sum = (sum == 0) ? 1 : sum*2;
                }
            }
            //Console.WriteLine("SUM: {0}", sum);
            total += sum;
        }

        Console.WriteLine("TOTAL: {0}", total);
    }

    static void Main(string[] args) {
        if (args.Length < 1) {
            Console.Error.WriteLine("Usage: " +
                                           System.AppDomain.CurrentDomain.FriendlyName +
                                           " <filename>");
            Environment.Exit(1);
        }

        Solve(args);
    }
}
