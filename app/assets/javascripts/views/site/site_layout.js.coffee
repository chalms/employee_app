class Metrics.Views.SiteLayout extends Marionette.Layout
  template: JST['templates/site_layout']

  regions: {
    siteNavbar: "#site-navbar",
    siteHome: "#site-home",
    siteFooter: "#site-footer",
  }
