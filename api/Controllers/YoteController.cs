using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using api;
using api.services;

namespace api.Controllers
{
    [Route("api")]
    public class YoteController : Controller
    {
        private YoteService _yoteService;
        public YoteController(YoteService yoteService)
        {
            _yoteService = yoteService;
        }

        [HttpGet("yotes/")]
        public IEnumerable<Yote> GetGroups([FromQuery] float lat, [FromQuery] float lng, [FromQuery] float height)
        {
            return _yoteService.GetNearbyYotes(lat, lng, height);
        }

        [HttpGet("yote/{id}")]
        public string GetGroup(int id)
        {
            return id.ToString();
        }

        [HttpPost("yote/")]
        public Yote PostYote([FromBody] Yote yote)
        {
            return _yoteService.AddYote(yote);
        }
    }
}
