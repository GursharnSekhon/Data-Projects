Select * 
From PortfolioProject..CovidDeaths 
Where continent is not null
Order by 3,4

--Select * 
--From PortfolioProject..CovidVaccinations
--Order by 3,4

Select Location, date, total_cases, new_cases, total_deaths, population 
From PortfolioProject..CovidDeaths
Order by 1,2

-- Looking at Total Cases vs Total Deaths
--Shows likelihood of dying if you contract covid in your country

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where location like '%Australia%'
and continent is not null
Order by 1,2

--Looking at Total Cases vs Population
--Shows what percentage of population got covid

Select Location, date, total_cases, population, (total_cases/population)*100 as PercentagePopulationInftected
From PortfolioProject..CovidDeaths
--Where location like '%Australia%'
Where continent is not null
Order by 1,2

--What countries have the highest infection rate compared to population

Select Location, population, Max(total_cases) as HighestInfectoinCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
--Where location like '%Australia%'
Where continent is not null
Group by Location, Population
Order by PercentPopulationInfected desc

--Showing Countires with Highest Death Count per Population

Select Location, Max(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%Australia%'
Where continent is not null
Group by Location
Order by TotalDeathCount desc

--LET'S BREAK THINGS DOWN BY CONTINENT



--Showing continents with the highest death counts

Select continent, Max(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%Australia%'
Where continent is not null
Group by continent
Order by TotalDeathCount desc


-- Global Numbers


Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
--Where location like '%Australia%'
Where continent is not null
Group by date
Order by 1,2



Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
--Where location like '%Australia%'
Where continent is not null
--Group by date
Order by 1,2


--Looking at Total Population vs Vaccinations

Select*
From PortfolioProject..CovidVaccinations vac
Join PortfolioProject..CovidDeaths dea
on dea.location = vac.location
and dea.date = vac.date



Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
Order by 2,3



--USE CTE
With PopvsVac (Continent, Location, Date, population, new_vaccinations, RollingPopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--Order by 2,3
)
Select *, (RollingPopleVaccinated/Population)*100 as VaccinatedPercentage
From PopvsVac


--Temp Table
DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--Order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100 
From #PercentPopulationVaccinated

-- Create View to store data for later viz

Create View PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--Order by 2,3
