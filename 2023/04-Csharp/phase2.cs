using System;
using System.IO;
using System.Text;
using System.Collections.Generic;
using System.Linq;

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
        int[] cards = new int[256];
        int cardID;
        int matches;


        // Process Line start
        foreach (var line in lines) {
            var winning = new List<int>();
            var taken = new List<int>();
            var head = line.Split(':')[0];
            var tail = line.Split(':')[1];

            cardID = Int32.Parse(FlatSpace(head.Trim(':')).Split()[1].Trim());
            //Console.WriteLine(cardID);
            var numbers = tail.Split('|');
            var winningNums = numbers[0].Trim();
            var takenNums = numbers[1].Trim().Trim('|');
            //Console.WriteLine(winningNums);
            //Console.WriteLine(takenNums);

            cards[cardID] += 1;
            foreach (var num in FlatSpace(winningNums).Split()) {
                winning.Add(Int32.Parse(num));
            }


            foreach (var num in FlatSpace(takenNums).Split()) {
                taken.Add(Int32.Parse(num));
            }

            matches = 0;
            foreach (var num in taken) {
                if (winning.Contains(num)) {
                    matches++;
                }
            }

            for (int i = 1; i <= matches; i++) {
                //Console.WriteLine("B: Card[{0}] = {1}", cardID+i, cards[cardID+i]);
                cards[cardID+i] += cards[cardID];
                //Console.WriteLine("A: Card[{0}] = {1}", cardID+i, cards[cardID+i]);
            }
            Console.WriteLine("Card[{0}] = {1}", cardID, cards[cardID]);
        }
        Console.WriteLine("SUM: {0}", cards.Sum());

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
