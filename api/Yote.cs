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
        public DbSet<YoteData> YoteData { get; set; }
        public DbSet<Yote> Yotes { get; set; }
        public DbSet<RelativeLocation> RelativeLocations { get; set; }
        public DbSet<YotePart> YoteParts { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlite("Data Source=EmoteYote.db");
        }
    }

    public class YoteData
    {
        public int YoteDataId { get; set; }
        public string YoteString { get; set; }
    }

    public class RelativeLocation
    {
        public int RelativeLocationId { get; set; }

        public int X { get; set; }
        public int Y { get; set; }
        public int Z { get; set; }
    }

    public class YotePart
    {
        public int YotePartId { get; set; }
        public int YoteId { get; set; }
        public int YoteDataId { get; set; }
        public List<RelativeLocation> Locations { get; set; }
    }

    public class Yote
    {
        public int YoteId { get; set; }

        [IgnoreDataMember]
        public List<YotePart> YoteParts { get; set; }

        public float X { get; set; }
        public float Y { get; set; }
        public float Z { get; set; }
    }
}
