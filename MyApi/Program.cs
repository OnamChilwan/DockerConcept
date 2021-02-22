using System;
using Microsoft.AspNetCore.Hosting;

namespace MyApi
{
    class Program
    {
        static void Main(string[] args)
        {
            var builder = new WebHostBuilder()
                .UseKestrel()
                .UseStartup<Startup>();
            var host = builder.Build();
            host.Run();
            
            Console.WriteLine("Hello World!");
            Console.Read();
        }
    }
}