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
<personnel>
: container for people involved in meeting
<attendee>
: person who was involved in the conversation
<host>
: person who led the discussion
<takeaway>
: lesson learned (conclusion) from the meeting
<ai>
: action item container
<aiDescription>
: defines action item acceptance criteria
<aiOwner>
: person resonsible for the action item (this is sub-element of <ai>
<aiDeadline>
: date action item is due by



