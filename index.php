<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome Page - Linux</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            color: #333;
            padding: 20px;
        }
        .welcome {
            text-align: center;
            font-size: 2em;
            font-weight: bold;
        }
        .welcome-secure {
            color: green;
        }
        .welcome-insecure {
            color: red;
        }
        .info {
            margin: 20px 0;
            padding: 10px;
            background-color: #f0f0f0;
            border-radius: 8px;
        }
        .https-status {
            font-weight: bold;
            text-align: center;
            margin-top: 10px;
            padding: 10px;
            border-radius: 5px;
        }
    </style>
</head>
<body style="background-color: <?php echo calculateBackgroundColor(); ?>;">

<?php
// Determine HTTPS status and set color classes
$httpsStatus = '';
$welcomeClass = '';

// Check for HTTPS using $_SERVER['HTTPS'] and $_SERVER['REQUEST_SCHEME']
$isHttps = !empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on';
$isHttps |= !empty($_SERVER['REQUEST_SCHEME']) && $_SERVER['REQUEST_SCHEME'] === 'https';

if ($isHttps) {
    $httpsStatus = 'This site is running on HTTPS.';
    $welcomeClass = 'welcome-secure';
} else {
    $httpsStatus = 'This site is running on HTTP.';
    $welcomeClass = 'welcome-insecure';
}

// Function to calculate background color based on IP address
function calculateBackgroundColor() {
    $serverIp = $_SERVER['SERVER_ADDR'] ?? '127.0.0.1'; // Default to localhost if not set
    $ipParts = explode('.', $serverIp);

    // Use the last three parts of the IP address as RGB values, default to 127 if not available
    $r = $ipParts[1] ?? 127;
    $g = $ipParts[2] ?? 127;
    $b = $ipParts[3] ?? 127;

    return "rgb($r, $g, $b)";
}
?>


    <h1 class="welcome <?php echo $welcomeClass; ?>">Welcome to <?php echo htmlspecialchars($_SERVER['HTTP_HOST']); ?> !</h1>
    <p class="https-status <?php echo $welcomeClass; ?>"><?php echo $httpsStatus; ?></p>

    <div class="info">
        <h2>Server and Client Information:</h2>
        <ul>
            <li><strong>Document Root:</strong> <?php echo htmlspecialchars($_SERVER['DOCUMENT_ROOT'] ?? 'Not available'); ?></li>
            <li><strong>Server IP Address:</strong> <?php echo htmlspecialchars($_SERVER['SERVER_ADDR'] ?? 'Not available'); ?></li>
            <?php foreach ($_SERVER as $key => $value): ?>
                <li><strong><?php echo htmlspecialchars($key); ?>:</strong> <?php echo htmlspecialchars($value); ?></li>
            <?php endforeach; ?>
        </ul>
    </div>
    <footer>
        &copy; 2024 WorldSkills Portugal. All rights reserved.
    </footer>
</body>
</html>
