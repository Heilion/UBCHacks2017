using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading.Tasks;
using System.Runtime.Serialization;

namespace api
{

    public class YoteContext : DbContext
    {
        public DbSet<Yote> Yotes { get; set; }
        
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlite("Data Source=./EmoteYote.db");
        }
    }

    public class Yote
    {
        public int YoteId { get; set; }

        public string Data { get; set; }

        public float X { get; set; }
        public float Y { get; set; }
        public float Z { get; set; }
    }
}
