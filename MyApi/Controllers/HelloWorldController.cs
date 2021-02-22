using Microsoft.AspNetCore.Mvc;

namespace MyApi.Controllers
{
    public class HelloWorldController
    {
        [HttpGet("api/foo")]
        public IActionResult Get()
        {
            return new OkObjectResult("hello world 2");
        }
    }
}