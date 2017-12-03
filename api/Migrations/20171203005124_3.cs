using Microsoft.EntityFrameworkCore.Migrations;
using System;
using System.Collections.Generic;

namespace api.Migrations
{
    public partial class _3 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "RelativeLocations");

            migrationBuilder.DropTable(
                name: "YoteData");

            migrationBuilder.DropTable(
                name: "YoteParts");

            migrationBuilder.AddColumn<string>(
                name: "Data",
                table: "Yotes",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Data",
                table: "Yotes");

            migrationBuilder.CreateTable(
                name: "YoteData",
                columns: table => new
                {
                    YoteDataId = table.Column<int>(nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    YoteString = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_YoteData", x => x.YoteDataId);
                });

            migrationBuilder.CreateTable(
                name: "YoteParts",
                columns: table => new
                {
                    YotePartId = table.Column<int>(nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    YoteDataId = table.Column<int>(nullable: false),
                    YoteId = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_YoteParts", x => x.YotePartId);
                    table.ForeignKey(
                        name: "FK_YoteParts_Yotes_YoteId",
                        column: x => x.YoteId,
                        principalTable: "Yotes",
                        principalColumn: "YoteId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "RelativeLocations",
                columns: table => new
                {
                    RelativeLocationId = table.Column<int>(nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    X = table.Column<int>(nullable: false),
                    Y = table.Column<int>(nullable: false),
                    YotePartId = table.Column<int>(nullable: true),
                    Z = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RelativeLocations", x => x.RelativeLocationId);
                    table.ForeignKey(
                        name: "FK_RelativeLocations_YoteParts_YotePartId",
                        column: x => x.YotePartId,
                        principalTable: "YoteParts",
                        principalColumn: "YotePartId",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_RelativeLocations_YotePartId",
                table: "RelativeLocations",
                column: "YotePartId");

            migrationBuilder.CreateIndex(
                name: "IX_YoteParts_YoteId",
                table: "YoteParts",
                column: "YoteId");
        }
    }
}
