Add-Type @"
using System.Management.Automation;

public class InvokePSModuleMethod
{
  PSObject module;
  public InvokePSModuleMethod(PSObject module)
  {
    this.module = module;
  }  

  public void InvokeTestMethod()
  {
    var method = module.Methods["test"];
    if(method != null) method.Invoke();
  }
}
"@

$module = New-Module -AsCustomObject {
    function test { "Hello World" | Out-Host }
}

(New-Object InvokePSModuleMethod $module).InvokeTestMethod()