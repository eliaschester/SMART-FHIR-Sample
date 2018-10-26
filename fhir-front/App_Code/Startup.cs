using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(fhir_front.Startup))]
namespace fhir_front
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
