using PCM.RENAC.Api.Modules.Authentication;
using PCM.RENAC.Api.Modules.Mapper;
using PCM.RENAC.Api.Modules.Swagger;
using PCM.RENAC.Api.Modules.Feature;
using PCM.RENAC.Api.Modules.Injection;
using PCM.RENAC.Api.Modules.Validator;
using PCM.RENAC.Application.Features;
using PCM.RENAC.Persistence;


var builder = WebApplication.CreateBuilder(args);
var configuration = builder.Configuration;

// Add services to the container.
builder.Services.AddRazorPages();
builder.Services.AddHttpClient();
builder.Services.AddMapper();
builder.Services.AddControllers();
//builder.Services.AddFeature(configuration);
builder.Services.AddPersistenceServices();
builder.Services.AddApplicationServices();
builder.Services.AddInjection(configuration);
builder.Services.AddAuthentication(configuration);
builder.Services.AddValidator();
builder.Services.AddSwagger();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
    app.UseSwagger();
    app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "pcm.gob.pe"));
}
else
{
    app.UseSwagger();
    app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "pcm.gob.pe"));
}

app.UseHttpsRedirection();
app.UseRouting();

app.UseCors(x =>
{
    x.AllowAnyOrigin();
    x.AllowAnyHeader();
    x.AllowAnyMethod();
});

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();

public partial class Program { };