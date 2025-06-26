# Snipping Tool Artifact Collection

This directory contains tools developed by Forscie to help investigators locate and collect artefacts left behind by Microsoft Snipping Tool and Snip & Sketch.

These applications are commonly used to capture screenshots or screen recordings, which may include sensitive data. In insider threat investigations or forensic triage, recovering these artefacts can provide critical context about user activity.

## Included Files

- **SnippingTool_Target.mkape**  
  A KAPE target file that defines known locations on disk where Snipping Tool saves images and recordings. It enables fast, automated collection during forensic triage.

- **Extract-SnippingToolArtifacts.ps1**  
  A PowerShell script that scans a user’s profile for Snipping Tool artefacts and copies them to a local folder for review. Designed for quick, lightweight use—especially on live systems.

## License

Licensed under the [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0). See the repository’s `LICENSE` file for more information.
