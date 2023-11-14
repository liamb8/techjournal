### Splunk Components and SPL Basics

#### Forwarders
- **Universal Forwarders (UF):** Lightweight agents that send data to indexers.
- **Heavy Forwarders (HF):** Agents that parse and route data.
- **HTTP Event Collectors (HECs):** Directly capture data from applications.

#### Indexers
- Receive, organize, and store data in indexes.
- Process search queries and return results.

#### Search Heads
- Coordinate search jobs and merge results.
- Provide a UI for Knowledge Objects, reports, dashboards, and visualizations.

#### Infrastructure
- **Deployment Server:** Manages configurations for forwarders.
- **Cluster Master:** Coordinates indexer activities in clusters.
- **License Master:** Manages Splunk platform licensing.

#### User Interface and Language
- **Splunk Web Interface:** Graphical interface for user interactions.
- **Search Processing Language (SPL):** Language for data querying and manipulation.

#### Apps and Add-ons
- **Splunkbase Apps:** Specialized functionalities within Splunk.
- **Technology Add-ons:** Extend capabilities and data handling.

#### Knowledge Objects
- Enhance data for easier searches and analysis.

### SPL Basic Commands

#### Basic Searching
- **Keywords and Wildcards:** `index="main" "error"` searches for the term "error" in the main index.
- **Boolean Operators:** Combine keywords with `AND`, `OR`, `NOT`.
- **Wildcard Characters:** `index="main" "*UNKNOWN*"` searches for terms that include "UNKNOWN".

#### Fields and Comparison Operators
- **Field Searching:** `index="main" EventCode!=4624` finds events where EventCode is not 4624.
- **Fields Command:** `index="main" sourcetype="WinEventLog:Security" EventCode=4624 | fields - User` removes the User field from results.

#### SPL Commands
- **Table Command:** `| table _time, host, Image` organizes results into a table.
- **Rename Command:** `| rename Image as Process` changes the field name Image to Process.
- **Dedup Command:** `| dedup Image` eliminates duplicate entries by the Image field.
- **Sort Command:** `| sort - _time` orders events by time, most recent first.
- **Stats Command:** `| stats count by _time, Image` counts events by time and process.
- **Chart Command:** `| chart count by _time, Image` visualizes event counts over time per process.
- **Eval Command:** `| eval Process_Path=lower(Image)` creates a new field with the lowercase version of Image.
- **Rex Command:** `| rex max_match=0 "[^%](?<guid>{.*})" | table guid` extracts and displays GUIDs using a regex pattern.
