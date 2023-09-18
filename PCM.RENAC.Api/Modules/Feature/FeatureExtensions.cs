using Microsoft.AspNetCore.Mvc;

namespace PCM.RENAC.Api.Modules.Feature
{
    public static class FeatureExtensions
    {
        public static IServiceCollection AddFeature(this IServiceCollection services, IConfiguration configuration)
        {
            string myPolicy = "policyApiPcmRenacConfiguracion";

            services.AddCors(options =>
            {
                options.AddPolicy(myPolicy, builder =>
                {
                    builder.WithOrigins(configuration["Config:OriginCors"])
                           .AllowAnyHeader()
                           .AllowAnyMethod();
                });
            });

            services.AddMvc()
                    .SetCompatibilityVersion(CompatibilityVersion.Latest);

            return services;
        }
    }
}
