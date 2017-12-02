using Microsoft.EntityFrameworkCore;

namespace api.services
{
    public class YoteService
    {
        private DbContext _dbContext;

       public YoteService(DbContext dbContext)
       {
           _dbContext = dbContext;
       }
    }
}