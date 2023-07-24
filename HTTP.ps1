$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost/PS/") # Replace with your desired URL

$listener.Start()

try {
    Write-Host "Listening for HTTP requests..."
    
    while ($true) {
        $context = $listener.GetContext()
        $request = $context.Request
        Write-Host "HTTP request received from: $($request.RemoteEndPoint.Address)"
        
        # Extract parameters from the URL
        $queryString = $request.QueryString
        $param1 = $queryString.Get("param1")
        Write-Host "Param1=$param1"
        $param2 = $queryString.Get("param2")
        Write-Host "Param2=$param2"

        # Perform your desired action here using the extracted parameters
        # For example, you can execute another script or launch an application.
        # You can access $param1 and $param2 to use the parameter values.

        $response = $context.Response
        $responseString = "Request received successfully. Parameters: Param1=$param1, Param2=$param2"
        $buffer = [System.Text.Encoding]::UTF8.GetBytes($responseString)
        $response.ContentLength64 = $buffer.Length
        $output = $response.OutputStream
        $output.Write($buffer, 0, $buffer.Length)
        $output.Close()
    }
}
catch {
    Write-Host "Error occurred: $_"
}
finally {
    $listener.Stop()
}
