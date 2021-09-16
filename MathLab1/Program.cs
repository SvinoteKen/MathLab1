using System;

namespace MathLab1
{
    class Program
    {
        static void Main(string[] args)
        {
            float fEpsilon = 1.0f;
            double dEpsilon = 1.0;
            float fInfinity = 1.0f;
            double dInfinity = 1.0;
            int count = 0;
            Console.WriteLine("Машинный ноль float :");
            do
            {
                fEpsilon /= 2;
                count++;
                Console.WriteLine(fEpsilon);
            }
            while (fEpsilon/2>0);
            Console.WriteLine("Iterations:" + count);
            Console.WriteLine("Машинный ноль float, средствами VS :"+float.Epsilon);
            count = 0;
            Console.WriteLine("Машинный ноль double :");
            do
            {
                count++;
                dEpsilon /= 2;
                Console.WriteLine(dEpsilon);
            }
            while (dEpsilon/2 > 0);
            Console.WriteLine("Iterations:" + count);
            Console.WriteLine("Машинный ноль double, средствами VS :" + double.Epsilon);
            count = 0;
            do
            {
                fInfinity *= 2;
                count++;
                Console.WriteLine(fInfinity);
            }
            while (fInfinity * 2 != float.PositiveInfinity);
            Console.WriteLine("Iterations:" + count);
            count = 0;
            do
            {
                dInfinity *= 2;
                count++;
                Console.WriteLine(dInfinity);
            }
            while (dInfinity * 2 != double.PositiveInfinity);
            Console.WriteLine("Iterations:" + count);
            Console.WriteLine("\nТип float(стандартная точность):");
        }
    }
}
