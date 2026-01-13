This deploys the utilization of log analytics workspace for traffic analytics.

## Notes

Traffic analytics automatically creates data collection endpoint (DCE) and data collection rule (DCR) resources prefixed with `NWTA-` in the log analytics workspace resource group.

These resources are managed by azure and may not be automatically deleted when the flow log is destroyed. Manual cleanup may be required.
