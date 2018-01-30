<#
.Synopsis
	Azure Sql Databases - Dummy Data Population
.DESCRIPTIOn
	This script is used to populate dummy data for use with the WingtipTickets application.
.EXAMPLE
	Populate-DBSchema 'ServerName', 'UserName', 'Password', 'DatabaseName'
.INPUTS
	1. ServerName
		Azure sql database server name for connection.
	2. UserName
		Username for sql database connection.
	3. Password
		Password for sql database connection.
	4. DatabaseName
		Azure Sql Database Name

.OUTPUTS
	By executing this script, you will receive messages regarding success or failure of data Insertion.
.NOTES
	The server name, user name, and password parameters are mandatory.
#>
function Populate-DBSchema
{
	[CmdletBinding()]
	Param
	(
		# WTT Environment Application Name
		[Parameter(Mandatory=$true)]
		[String]
		$azureResourceGroupName,

		# Azure SQL server name for connection.
		[Parameter(Mandatory=$true)]
		[String]
		$AzureSqlServerName,

		# Azure SQL db user name for connection.
		[Parameter(Mandatory=$true)]
		[String]
		$AdminUserName,

		# Azure SQL db password for connection.
		[Parameter(Mandatory=$true)]
		[String]
		$AdminPassword,

		# Azure SQL database name.
		[Parameter(Mandatory=$true)]
		[String]
		$AzureSqlDatabaseName
	)

	Process
	{
		Try
		{
			$testSQLConnection = Test-WTTAzureSQLConnection -AzureSqlServerName $AzureSqlServerName -AdminUserName $AdminUserName -AdminPassword $AdminPassword -AzureSqlDatabaseName $AzureSqlDatabaseName -azureResourceGroupName $azureResourceGroupName
            if ($testSQLConnection -notlike "success")
            {
                WriteError("Unable to connect to SQL Server")
            }
            Else
            {
			    # Build the required connection details
			    $ConnectionString = "Server=tcp:$AzureSqlServerName.database.windows.net; Database=$AzureSqlDatabaseName; User ID=$AdminUserName; Password=$AdminPassword; Trusted_Connection=False; Encrypt=True;"

			    $Connection = New-object system.data.SqlClient.SqlConnection($ConnectionString)
			    $Command = New-Object System.Data.SqlClient.SqlCommand('',$Connection)
                $Command.CommandTimeout = 0

			    # Open the connection to the Database
			    WriteLabel("Connecting to database")
			    $Connection.Open()
			    If(!$Connection)
			    {
				    throw "Failed to Connect $ConnectionString"
			    }
			    WriteValue("Successful")

			    # Clean Tables
			    LineBreak

				WriteLabel("Cleaning ApplicationDefaults table")
				$Command.CommandText = "DELETE FROM ApplicationDefault"
				$Result = $Command.ExecuteNonQuery()
				WriteValue("Successful")
 
			    WriteLabel("Cleaning Customers table")
			    $Command.CommandText = "Delete From Customers"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    WriteLabel("Cleaning Organizers table")
			    $Command.CommandText = "Delete From Organizers"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    WriteLabel("Cleaning SeatSection table")
			    $Command.CommandText = "Delete From SeatSection"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

				WriteLabel("Cleaning SeatSectionLayout table")
			    $Command.CommandText = "Delete From SeatSectionLayout"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    WriteLabel("Cleaning Venues table")
			    $Command.CommandText = "Delete From Venues"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    WriteLabel("Cleaning City table")
			    $Command.CommandText = "Delete From City"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    WriteLabel("Cleaning States table")
			    $Command.CommandText = "Delete From States"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    WriteLabel("Cleaning Country table")
			    $Command.CommandText = "Delete From Country"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    WriteLabel("Cleaning WebSiteActionLog table")
			    $Command.CommandText = "Delete From WebSiteActionLog"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    WriteLabel("Cleaning Concerts table")
			    $Command.CommandText = "Delete From Concerts"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    WriteLabel("Cleaning Performers table")
			    $Command.CommandText = "Delete From Performers"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    WriteLabel("Cleaning TicketLevels table")
			    $Command.CommandText = "Delete From TicketLevels"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    WriteLabel("Cleaning Tickets table")
			    $Command.CommandText = "Delete From Tickets"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")
				
				WriteLabel("Cleaning Discount table")
			    $Command.CommandText = "Delete From Discount"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

				WriteLabel("Cleaning AllSeats table")
			    $Command.CommandText = "Delete From AllSeats"
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

				
				# Populate ApplicationDefaults Table
				WriteLabel("Populating ApplicationDefaults table")
				$Command.CommandText =
					"
						SET Identity_Insert [dbo].[ApplicationDefault] ON
						
						INSERT [dbo].[ApplicationDefault] ([ApplicationDefaultId], [Code], [Value]) VALUES (1, 'DefaultReportId', 'a1fb60c9-3cef-4bb4-af2a-5e1b39114214')
						
						SET Identity_Insert [dbo].[ApplicationDefault] OFF
					"

				$Result = $Command.ExecuteNonQuery()
				WriteValue("Successful")

			    # Populate Customers Table
			    $Command.CommandText =
				    "INSERT INTO [dbo].[Customers]([FirstName], [LastName], [Email], [Password]) VALUES 
					    (N'admin', N'admin', N'admin@admin.com', N'P@ssword1'),
					    (N'Mike', N'Flasko', N'mike.flasko@microsoft.com', N'P@ssword1'),
					    (N'Gaurav', N'Malhotra', N'gamal@microsoft.com', N'P@ssword1')
				    "

			    LineBreak
			    WriteLabel("Populating Customers table")
			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    # Populate Countries Table
			    WriteLabel("Populating Countries table")
			    $Command.CommandText =
				    "
					    Set Identity_Insert [dbo].[Country] On 
					    Insert [dbo].[Country] ([CountryId], [CountryName], [Description]) Values (1, N'United States', NULL)
					    Set Identity_Insert [dbo].[Country] Off
				    "

			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    # Populate States Table
			    WriteLabel("Populating States table")
			    $Command.CommandText =
				    "
					    Set Identity_Insert [dbo].[States] On
					    Insert [dbo].[States] ([StateId], [StateName], [Description], [CountryId]) Values (1, N'CA', NULL, 1)
					    Insert [dbo].[States] ([StateId], [StateName], [Description], [CountryId]) Values (2, N'CO', NULL, 1)
					    Insert [dbo].[States] ([StateId], [StateName], [Description], [CountryId]) Values (3, N'FL', NULL, 1)
					    Insert [dbo].[States] ([StateId], [StateName], [Description], [CountryId]) Values (4, N'MA', NULL, 1)
					    Insert [dbo].[States] ([StateId], [StateName], [Description], [CountryId]) Values (5, N'MI', NULL, 1)
					    Insert [dbo].[States] ([StateId], [StateName], [Description], [CountryId]) Values (6, N'NY', NULL, 1)
					    Insert [dbo].[States] ([StateId], [StateName], [Description], [CountryId]) Values (7, N'OR', NULL, 1)
					    Insert [dbo].[States] ([StateId], [StateName], [Description], [CountryId]) Values (8, N'TX', NULL, 1)
					    Insert [dbo].[States] ([StateId], [StateName], [Description], [CountryId]) Values (9, N'UT', NULL, 1)
					    Insert [dbo].[States] ([StateId], [StateName], [Description], [CountryId]) Values (10, N'WA', NULL, 1)
					    Set Identity_Insert [dbo].[States] Off
				    "

			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    # Populate City Table
			    WriteLabel("Populating City table")
			    $Command.CommandText =
				    "
					    Set Identity_Insert [dbo].[City] On 
					    Insert [dbo].[City] ([CityId], [CityName], [Description], [StateId]) Values (1, N'Los Angeles', NULL, 1)
					    Insert [dbo].[City] ([CityId], [CityName], [Description], [StateId]) Values (2, N'Denver', NULL, 2)
					    Insert [dbo].[City] ([CityId], [CityName], [Description], [StateId]) Values (3, N'Jacksonville', NULL, 3)
					    Insert [dbo].[City] ([CityId], [CityName], [Description], [StateId]) Values (4, N'Boston', NULL, 4)
					    Insert [dbo].[City] ([CityId], [CityName], [Description], [StateId]) Values (5, N'Detroit', NULL, 5)
					    Insert [dbo].[City] ([CityId], [CityName], [Description], [StateId]) Values (6, N'Syracuse', NULL, 6)
					    Insert [dbo].[City] ([CityId], [CityName], [Description], [StateId]) Values (7, N'Portland', NULL, 7)
					    Insert [dbo].[City] ([CityId], [CityName], [Description], [StateId]) Values (8, N'Austin', NULL, 8)
					    Insert [dbo].[City] ([CityId], [CityName], [Description], [StateId]) Values (9, N'Salt Lake City', NULL, 9)
					    Insert [dbo].[City] ([CityId], [CityName], [Description], [StateId]) Values (10, N'Seattle', NULL, 10)
					    Insert [dbo].[City] ([CityId], [CityName], [Description], [StateId]) Values (11, N'Spokane', NULL, 10)
					    Set Identity_Insert [dbo].[City] Off
				    "

			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    # Populate Venues Table
			    WriteLabel("Populating Venues table")
			    $Command.CommandText =
    				"
	    				Set Identity_Insert [dbo].[Venues] On 
		    			Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId], [Longitude], [Latitude]) Values (1, N'Conrad Fischer Stands', 1000, N'', 1, -118.2437, 34.0522)
						Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId], [Longitude], [Latitude]) Values (2, N'Hayden Lawrence Gardens', 1000, N'', 2, -104.9903, 39.7392)
						Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId], [Longitude], [Latitude]) Values (3, N'Rene Charron Highrise', 1000, N'', 3, -81.6557, 30.3322)
						Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId], [Longitude], [Latitude]) Values (4, N'Aldo Richter Hall', 1000, N'', 4, -71.0589, 42.3601)
						Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId], [Longitude], [Latitude]) Values (5, N'Harriet Collier Auditorium', 1000, N'', 5, -83.0458, 42.3314)
						Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId], [Longitude], [Latitude]) Values (6, N'Samuel Boyle Center', 1000, N'', 6, -76.1474, 43.0481)
						Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId], [Longitude], [Latitude]) Values (7, N'Millie Stevens Memorial Plaza', 1000, N'', 7, -122.6765, 45.5231)
						Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId], [Longitude], [Latitude]) Values (8, N'Louisa Zimmerman Stadium', 1000, N'', 8 , -97.7431, 30.2672)
						Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId], [Longitude], [Latitude]) Values (9, N'Lara Ehrle Amphitheter', 1000, N'', 9, -111.8910, 40.7608)
						Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId], [Longitude], [Latitude]) Values (10, N'Antione Lacroix Dome', 1000, N'', 10, -122.3321, 47.6062)
						Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId], [Longitude], [Latitude]) Values (11, N'Claude LAngelier Field', 1000, N'', 11, -117.4260, 47.6588)
						Insert [dbo].[Venues] ([VenueId], [VenueName], [Capacity], [Description], [CityId], [Longitude], [Latitude]) Values (12, N'Maya Haynes Arena', 1000, N'', 10, -122.3321, 47.6062)
					    Set Identity_Insert [dbo].[Venues] Off
				    "

			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    # Populate SeatSection Table
			    WriteLabel("Populating SeatSection table")
			    $Command.CommandText =
					"
						Declare @index numeric = 1

						While @index <= 12
						Begin
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (60,  @index,  N'Orchestra Pit')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (100, @index,  N'Orchestra Front')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (194, @index,  N'Orchestra Back')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (8,   @index,  N'Box 1')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (8,   @index,  N'Box 2')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (8,   @index,  N'Box 3')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (8,   @index,  N'Box 4')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (32,  @index,  N'1st Tier 1')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (32,  @index,  N'1st Tier 2')
							Insert [dbo].[SeatSection] ([SeatCount], [VenueId], [Description]) Values (198, @index,  N'2nd Tier')

							Set @index = @index + 1
						End
					"

			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")
				
				# Populate SeatSectionLayout Table
			    WriteLabel("Populating SeatSectionLayout table")
			    $Command.CommandText =
					"
						Declare @indexSection numeric = 1
						Declare @indexConcert numeric = 1

						While @indexConcert <= 12
						Begin

							--  Orchestra Pit
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 0, 1, 0, 1,  20)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 0, 2, 0, 21, 40)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 0, 3, 0, 41, 60)

							-- Orchestra Front
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 1, 1, 0, 1,  20)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 1, 2, 0, 21, 40)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 1, 3, 0, 41, 60)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 1, 4, 0, 61, 80)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 1, 5, 0, 81, 100)
							
							-- Orchestra Back
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 2, 1,  0,  1,   20)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 2, 2,  0,  21,  40)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 2, 3,  0,  41,  60)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 2, 4,  0,  61,  80)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 2, 5,  0,  81,  100)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 2, 6,  0,  101, 120)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 2, 7,  0,  121, 140)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 2, 8,  0,  141, 160)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 2, 9,  1,  161, 178)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 2, 10, 2,  179, 194)

							-- Box 1
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 3, 1, 0, 1, 2)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 3, 2, 0, 3, 4)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 3, 3, 0, 5, 6)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 3, 4, 0, 7, 8)

							-- Box 2
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 4, 1, 0, 1, 2)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 4, 2, 0, 3, 4)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 4, 3, 0, 5, 6)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 4, 4, 0, 7, 8)

							-- Box 3
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 5, 1, 0, 1, 2)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 5, 2, 0, 3, 4)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 5, 3, 0, 5, 6)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 5, 4, 0, 7, 8)

							-- Box 4
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 6, 1, 0, 1, 2)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 6, 2, 0, 3, 4)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 6, 3, 0, 5, 6)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 6, 4, 0, 7, 8)

							-- 1st Tier 1
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 7, 1, 0,  1,  7)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 7, 2, 0,  8,  14)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 7, 3, 0,  15, 21)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 7, 4, 0,  22, 27)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 7, 5, 0,  28, 32)

							-- 1st Tier 2
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 8, 1, 0,  1,  7)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 8, 2, 0,  8,  14)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 8, 3, 0,  15, 21)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 8, 4, 1,  22, 27)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 8, 5, 2,  28, 32)

							-- 2nd Tier
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 9, 1,  4,  1,   15)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 9, 2,  4,  16,  30)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 9, 3,  4,  31,  45)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 9, 4,  4,  46,  60)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 9, 5,  0,  61,  83)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 9, 6,  0,  84,  106)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 9, 7,  0,  107, 129)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 9, 8,  0,  130, 152)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 9, 9,  0,  153, 175)
							INSERT [dbo].[SeatSectionLayout] ([SeatSectionId], [RowNumber], [SkipCount], [StartNumber], [EndNumber]) Values (@indexSection + 9, 10, 0,  176, 198)

							Set @indexConcert = @indexConcert + 1
							Set @indexSection = @indexSection + 10
						End
					"

			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    # Populate Concerts Table
			    WriteLabel("Populating Concerts table")
				$date = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
			    $Command.CommandText =
				    "
					    Set Identity_Insert [dbo].[Concerts] On 
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (1, N'Julie and the Plantes Illumination Tour', N'', '$date', 3, 1, 1, 0)
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (2, N'Julie and the Plantes Illumination Tour', N'', '$date', 3, 2, 1, 0)
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (3, N'Julie and the Plantes Illumination Tour', N'', '$date', 3, 3, 1, 0)
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (4, N'Julie and the Plantes Illumination Tour', N'', '$date', 3, 4, 1, 0)
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (5, N'Julie and the Plantes Illumination Tour', N'', '$date', 3, 5, 1, 0)
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (6, N'Julie and the Plantes Illumination Tour', N'', '$date', 3, 6, 1, 0)
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (7, N'Julie and the Plantes Illumination Tour', N'', '$date', 3, 7, 1, 0)
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (8, N'Julie and the Plantes Illumination Tour', N'', '$date', 3, 8, 1, 0)
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (9, N'Julie and the Plantes Illumination Tour', N'', '$date', 3, 9, 1, 0)
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (10, N'Julie and the Plantes Illumination Tour', N'', '$date', 3, 10, 1, 0)
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (11, N'Julie and the Plantes Illumination Tour', N'', '$date', 3, 11, 1, 0)
					    Insert [dbo].[Concerts] ([ConcertId], [ConcertName], [Description], [ConcertDate], [Duration], [VenueId], [PerformerId], [SaveToDbServerType]) Values (12, N'Julie and the Plantes Illumination Tour', N'', '$date', 3, 12, 1, 0)
					    Set Identity_Insert [dbo].[Concerts] Off
				    "

			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    # Populate Performers Table
			    WriteLabel("Populating Performers table")
			    $Command.CommandText =
				    "
					    SET IDENTITY_INSERT [dbo].[Performers] ON 
					    INSERT [dbo].[Performers] ([PerformerId], [FirstName], [LastName], [Skills], [ContactNbr], [ShortName]) VALUES (1, N'Julie', N'Plantes', N'PopMusic', CAST(1234567891 AS Numeric(15, 0)), N'Julie and the Plantes')                
					    SET IDENTITY_INSERT [dbo].[Performers] OFF
				    "

			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")

			    # Populate TicketLevels Table
			    WriteLabel("Populating TicketLevels table")
			    $Command.CommandText =
				    "
						Declare @indexSection numeric = 1
						Declare @indexConcert numeric = 1

						While @indexConcert <= 12
						Begin

							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 1', 'Orchestra Pit - `$100.00', @indexSection + 0,  @indexConcert, 100)
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 1', 'Orchestra Front - `$80.00',  @indexSection + 1,  @indexConcert, 80)
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 1', 'Orchestra Back - `$60.00',  @indexSection + 2,  @indexConcert, 60)
																																																	
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 2', 'Box 1 - `$90.00',  @indexSection + 3,  @indexConcert, 90)
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 2', 'Box 2 - `$90.00',  @indexSection + 4,  @indexConcert, 90)
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 2', 'Box 3 - `$70.00',  @indexSection + 5,  @indexConcert, 70)
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 2', 'Box 4 - `$70.00',  @indexSection + 6,  @indexConcert, 70)
																																																	
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 3', '1st Tier 1 - `$50.00',  @indexSection + 7,  @indexConcert, 50)
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 3', '1st Tier 2 - `$50.00',  @indexSection + 8,  @indexConcert, 50)
																																																	
							Insert [dbo].[TicketLevels] ([TicketLevel], [Description], [SeatSectionId], [ConcertId], [TicketPrice]) Values ('Level 4', '2nd Tier - `$35.00',  @indexSection + 9,  @indexConcert, 35)

							Set @indexConcert = @indexConcert + 1
							Set @indexSection = @indexSection + 10
						End
				    "

			    $Result = $Command.ExecuteNonQuery()
			    WriteValue("Successful")
        }
    }
	    Catch 
	    { 
	        WriteError("$Error")
	    }
	    Finally
	    {
	        $Command = $null
		    $ConnectionString = $null

		    if ($Connection -ne $null -and $Connection.State -eq "Open") 
		    { 
		        $Connection.close(); 
			    $Connection = $null; 
		    }
	    }
    }
}