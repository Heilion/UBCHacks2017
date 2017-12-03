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
			return this._dbContext.Yotes.Where((yote) => CalcDistance(x, y, z, yote.X, yote.Y, yote.Z) < 1).ToList();
		}

		public double CalcDistance(float x1, float y1, float z1, float x2, float y2, float z2)
		{
			var x = x2 - x1;
			var y = y2 - y1;
			var z = (z2 - z1) * 0.5;

			return Math.Sqrt(Math.Pow(x, 2) + Math.Pow(y, 2) + Math.Pow(z, 2));
		}

//http://dotnet-snippets.com/snippet/calculate-distance-between-gps-coordinates/677
		private class Location
		{
			public double Latitude { get; set; }
			public double Longitude { get; set; }
		}

		private static double DegreesToRadians(double degrees)
		{
			return degrees * Math.PI / 180.0;
		}

		private static double CalculateDistance(Location location1, Location location2)
		{
			double circumference = 40000.0; // Earth's circumference at the equator in km
			double distance = 0.0;

			//Calculate radians
			double latitude1Rad = DegreesToRadians(location1.Latitude);
			double longitude1Rad = DegreesToRadians(location1.Longitude);
			double latititude2Rad = DegreesToRadians(location2.Latitude);
			double longitude2Rad = DegreesToRadians(location2.Longitude);

			double logitudeDiff = Math.Abs(longitude1Rad - longitude2Rad);

			if (logitudeDiff > Math.PI)
			{
				logitudeDiff = 2.0 * Math.PI - logitudeDiff;
			}

			double angleCalculation =
				Math.Acos(
				  Math.Sin(latititude2Rad) * Math.Sin(latitude1Rad) +
				  Math.Cos(latititude2Rad) * Math.Cos(latitude1Rad) * Math.Cos(logitudeDiff));

			distance = circumference * angleCalculation / (2.0 * Math.PI);

			return distance;
		}

		private static double CalculateDistance(params Location[] locations)
		{
			double totalDistance = 0.0;

			for (int i = 0; i < locations.Length - 1; i++)
			{
				Location current = locations[i];
				Location next = locations[i + 1];

				totalDistance += CalculateDistance(current, next);
			}

			return totalDistance;
		}

	}
}