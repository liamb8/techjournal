# SIEM Visualization Example 1: Failed Logon Attempts (All Users)



## Summary:

In this lab, I crafted a comprehensive dashboard visualization in Kibana, focusing on tracking failed logon attempts across all users on Windows systems. The process began with the integration of a filter based on the event ID `4625 – Failed logon attempt on a Windows system`. Transitioning to the visualization phase, I selected a table format and incorporated rows for both the `user.name.keyword` field, representing the specific username associated with the failed logon, and the `host.hostname.keyword` field, denoting the system's hostname. To offer a quantitative insight into the security incidents, I integrated a metrics row utilizing the count function, thereby displaying the total number of failed logon attempts.

![image-20231016233716246](C:\Users\Liam\AppData\Roaming\Typora\typora-user-images\image-20231016233716246.png)

The dashboard can also be refined further by adding clearer column names, logon type, and sorting the results. See the screenshot below for the updated version:

![image-20231016235120607](C:\Users\Liam\AppData\Roaming\Typora\typora-user-images\image-20231016235120607.png)

## **Skills and Tools Used:**

- **Kibana:** Employed for dashboard visualization and data analysis.
- **Data Filtering:** Strategically used event IDs to curate and focus the dataset.
- **Table Creation:** Demonstrated proficiency in designing and organizing tabular visual representations.
- **Data Metrics:** Utilized the count function to quantitatively represent failed logon attempts.

## **Achievements and Takeaways:**

- **Focused Visualization:** Successfully synthesized a Kibana dashboard honing in on failed logon attempts across all Windows system users, offering a clear snapshot of security incidents.
- **Precision in Data Curation:** Showcased adeptness in refining data by applying a specific event ID filter, leading to more accurate and relevant visualizations.
- **Enhanced User Experience:** Proactively refined the dashboard for better usability, by introducing intuitive column names, incorporating logon types, and methodically sorting results for optimized readability.
- **Comprehensive Analysis:** Through the amalgamation of the `user.name.keyword` and `host.hostname.keyword` fields, delivered a detailed breakdown of failed logons, delineating both the affected user and associated system.