      $PesterModule = Get-Module -Name Pester -ListAvailable
      if (-Not($PesterModule.Version -gt '5.0.0')) {
        Install-Module -Name Pester -MinimumVersion 5.0.0 -Force -SkipPublisherCheck
      }
      
      Invoke-Pester "$PSScriptRoot/Tests/" -Output "./Test-Pester.XML" -OutputFormat "NUnitXML"
