# King County Evictions

## Project Description
The data set our group will be focusing on for our final project contains information about eviction (unlawful detainer) cases in King County. The data was collected by the *King County Bar Association Housing Justice Project*. One of the group members (Alyssa) was a part of the research team that collected information from cases and translated it into a readable form of data.

[The Housing Justice Project](https://www.kcba.org/For-the-Public/Free-Legal-Assistance/Housing-Justice-Project) is a valuable resource in the King County area, providing free same day legal help to low income tenants facing eviction. One of the main goals of collecting this data was to outline the number of evictions happening in the county, and especially those that were “no cause” terminations. Washington State is unique in the sense that it has very loose protections for tenants and the Housing Justice Project is _currently_ in the process of lobbying in the state legislature a bill that would create reform.

>“HB 1453/SB 5600 would reduce the number of tenants becoming homeless due to a one-time medical emergency, temporary unemployment, or other setback. The Seattle Women's Commission and King County Bar Association's report, "Losing Home," found that most evictions occurred after a tenant fell behind one-month or less in rent and almost 90% of surveyed tenants were rendered homeless and without permanent housing after an eviction. These bills would make the process more fair: 1) the bills extends the time before a tenant can be defaulted on rent from 3 days to 14 days, which is recommended by the Uniform Residential Landlord-Tenant Act and currently the law in states like Tennessee, Massachusetts, Minnesota, and Wisconsin (Washington D.C. even requires a 30-day notice for nonpayment of rent); 2) the bill would allow a court to consider the reasons why a tenant fell behind and permit a tenant to stay if all rent is paid” (King County Bar Association).

That stated, the target audience would then be focused on the representatives and lobbying groups that have the power to push the bill through the Washington State Legislature.

Below are 3 specific questions that our project will answer for our audience:
- How many evictions are due to amounts less than one month's rent?
- How many are no cause v.s. non payment of rent v.s. others?
- Which area(by zip code) has the most evictions?


## Technical Description

We have our data in the form of a ``.csv `` file so we will be reading it into R as a `dataframe`. The addresses of each eviction are written out as strings, so we are planning on utilizing the `geocode()` function from `ggmap` and/or leveraging the Google Maps API for geolocation. Additionally we may have to do some reformatting to arrange and filter values but that should be simple enough with `dplyr`. The major challenge we are facing is cleaning up the data. Not every eviction has data for each column, so we are going to have to decide what amount of information we deem sufficient enough to work with and then somehow filter out those entries that were not complete enough for our purposes.
