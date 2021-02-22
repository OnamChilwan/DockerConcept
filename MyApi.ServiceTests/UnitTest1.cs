using System;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using NUnit.Framework;

namespace MyApi.ServiceTests
{
    [TestFixture]
    public class Tests
    {
        [Test]
        public async Task DoStuff()
        {
            using (var httpClient = new HttpClient())
            {
                httpClient.BaseAddress = new Uri("http://localhost:80");
                var result = await httpClient.GetAsync("api/foo");
                
                Assert.That(result.StatusCode, Is.EqualTo(HttpStatusCode.OK));
            }
        }
    }
}