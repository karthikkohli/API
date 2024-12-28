<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>City to Country Lookup</title>
    <link rel="stylesheet" href="StyleSheet1.css"/>
</head>
<body>
    <center>
    <h2>Find Country by City</h2>
    <label for="name">Enter City Name:</label>
    <input type="text" id="name" placeholder="Enter city name"> <br /> <br />
    <button onclick="loadDoc()">Submit</button>
    <br><br>
    <div id="demo" style="font-weight: bold;"></div>
        </center>

    <script>
        function loadDoc() {
            let cityName = document.getElementById("name").value.trim();
            const demo = document.getElementById("demo");

            if (!cityName) {
                demo.innerHTML = "Please enter a city name.";
                return;
            }

            const xhttp = new XMLHttpRequest();
            xhttp.onload = function () {
                if (this.status === 200) {
                    try {
                        const response = JSON.parse(this.responseText);
                        const cities = response.data;
                        let countryFound = false;

                        // Search through the cities to find the matching one
                        for (let i = 0; i < cities.length; i++) {
                            if (cities[i].city.toLowerCase() === cityName.toLowerCase()) {
                                demo.innerHTML = `
                                    <strong>City:</strong> ${cities[i].city}<br>
                                    <strong>Country:</strong> ${cities[i].country}
                                `;
                                countryFound = true;
                                break;
                            }
                        }

                        if (!countryFound) {
                            demo.innerHTML = `City "${cityName}" not found. Please try another city.`;
                        }
                    } catch (error) {
                        demo.innerHTML = "Error processing the response. Please try again.";
                        console.error("JSON Parsing Error:", error);
                    }
                } else {
                    demo.innerHTML = "Error fetching data. Please check your internet connection and try again.";
                }
            };

            xhttp.onerror = function () {
                demo.innerHTML = "Network error. Unable to fetch data.";
            };

            // Fetch the cities data
            xhttp.open("GET", "https://countriesnow.space/api/v0.1/countries/population/cities", true);
            xhttp.send();
        }
    </script>
</body>
</html>
