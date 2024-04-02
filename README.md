# Purpose
Create a structure for note taking with xml tags such that notes can be easily referenced in the future

# Architecture
```
Life Domain
    Subdomain
        ...
        Date/Time
```

### Architecture Example
```
Work
    Company
        TeamName
            Project
                Task
                    DateTime.txt (contains raw notes from the meeting)
                    DateTime.xml (contains tags from processing the txt)
```

# Tags
see tags.csv


