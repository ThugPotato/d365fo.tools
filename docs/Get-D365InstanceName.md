﻿---
external help file: d365fo.tools-help.xml
Module Name: d365fo.tools
online version:
schema: 2.0.0
---

# Get-D365InstanceName

## SYNOPSIS
Gets the instance name

## SYNTAX

```
Get-D365InstanceName [<CommonParameters>]
```

## DESCRIPTION
Get the instance name that is registered in the environment

## EXAMPLES

### EXAMPLE 1
```
Get-D365InstanceName
```

This will get the service name that the environment has configured

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Tags: Instance, Servicing

Author: Rasmus Andersen (@ITRasmus)

The cmdlet wraps the call against a dll file that is shipped with Dynamics 365 for Finance & Operations.
The call to the dll file gets HostedServiceName that is registered in the environment.

## RELATED LINKS
