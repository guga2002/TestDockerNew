using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace TestDockerNew.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ValuesController : ControllerBase
    {

        [HttpGet("getNew")]
        public async Task<IActionResult> Get()
        {
            // Simulate a delay to mimic a long-running operation
            await Task.Delay(1000);
            return Ok(new { Message = "Hello from ValuesController!" });
        }
    }
}
