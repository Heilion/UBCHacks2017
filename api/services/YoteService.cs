using Microsoft.EntityFrameworkCore;
using System.Linq;
using api;
using System;
using System.Collections.Generic;

namespace api.services
{
    public class YoteService
    {
       private YoteContext _dbContext;

       public YoteService(YoteContext dbContext)
       {
           _dbContext = dbContext;
       }

        public List<Yote> GetNearbyYotes(float x, float y, float z)
        {
            //return this._dbContext.Yotes.Where((yote) => CalcDistance(x, y, z, yote.X, yote.Y, yote.Z) < 1).ToList();
            var list = this._dbContext.Yotes.ToList();
            return list;
        }

        public double CalcDistance(float x1, float y1, float z1, float x2, float y2, float z2)
        {
            var x = x2 - x1;
            var y = y2 - y1;
            var z = (z2 - z1) * 0.5;

            return Math.Sqrt(Math.Pow(x, 2) + Math.Pow(y, 2) + Math.Pow(z, 2));
        }

        public Yote AddYote(Yote yote)
        {
            var ret = this._dbContext.Yotes.Add(yote);
            this._dbContext.SaveChanges();

            return ret.Entity as Yote;
        }
    }
}