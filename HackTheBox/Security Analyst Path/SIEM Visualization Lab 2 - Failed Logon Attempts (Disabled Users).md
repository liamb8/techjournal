# SIEM Visualization Lab 2: Failed Logon Attempts (Disabled Users)



## Summary:

In this lab, I developed a Kibana visualization to monitor Failed Logon Attempts targeting Windows system users. To achieve precise results, I applied a filter based on the event ID `4625 – Failed logon attempt on a Windows system`. Additionally, I referenced the `winlog.event_data.SubStatus` field set to `0xC0000072`, pinpointing failures resulting from logon attempts with disabled user accounts. To ensure data accuracy, I incorporated the `user.name.keyword` field. The final visualization took the form of a table, detailing the `user.name.keyword` (showcasing the username) and employing the metrics count function to represent the number of relevant records. The visualization was further enriched with the `host.hostname.keyword` row, revealing the hostname associated with each failed logon attempt.

![image-20231016225925800](https://github.com/liamb8/techjournal/blob/master/HackTheBox/Security%20Analyst%20Path/Pictures/lab2.JPG)

## **Skills and Tools Used:**

- **Kibana:** Utilized for data visualization and analysis.
- **Data Filtering:** Applied specific filters using event IDs and SubStatus values to curate the data.
- **Data Verification:** Ensured the accuracy and relevance of data by referencing specific fields.
- **Table Creation:** Designed a table visualization to effectively represent the data.

## **Achievements and Takeaways:**

- **Precision in Visualization:** Crafted a focused Kibana visualization that zeroes in on Failed Logon Attempts for Windows system users.
- **Detailed Analysis:** Leveraged specific filters such as event ID `4625` and SubStatus `0xC0000072` to discern and spotlight failed logon attempts specifically associated with disabled user accounts.
- **Data Accuracy:** Validated the reliability of the visualized data by cross-referencing the `user.name.keyword` field.
- **Comprehensive Representation:** Enriched the visualization with several rows, presenting both the username and hostname. The metrics count function was pivotal in displaying the exact number of failed logon attempts, offering a clear quantitative insight into security events.