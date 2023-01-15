-- Corona 8 New Tonemapper struct wrapper
-- version : 1.0
-- 2022-july-10
-- =========================================
-- by Mohammadreza Mohseni
-- =========================================
-- mohamad.r.mohseni@gmail.com

-- www.instagram.com/mohseni.mr/
-- twitter.com/_mohseni
-- www.facebook.com/mohamadreza.mohseni/
-- =========================================
-- License: GNU General Public License v3.0 
-- =========================================

struct crnToneMapping (
	-- Delete all tone mapping operators
	fn ClearAllTMOperators = (
		-- do not use :: renderers.current.colorMap_pipeline = undefined or null :: it will not clear frame buffer tone mappings
		try(
			renderers.current.colorMap_pipeline = IdentityOperatorPlugin()
		)
		catch (
			format ":: ❌ Error :: Corona Tone Mapping - Code CTM-1001 ::\n-- Delete all tone mapping operators was not successful.\n%\n" (getCurrentException())
			undefined
		)
	),
	
	-- Get all tone mapping operators and their IDs as an array
	-- #(( tmOP_1, tmOP_1 ID ), ( tmOP_1, tmOP_1 ID ), ( tmOP_1, tmOP_1 ID ), ...)
	fn GetAllTMOperatorsPlusIDs = (
		try(
			tmOPs = #()
			tmOPplus = #()
			tmOP = renderers.current.colorMap_pipeline 
			if (not ( isProperty tmOP #colorMappingOperator_nextOperator )) then ClearAllTMOperators()
			while ((tmOP != undefined ) and (classof tmOP != IdentityOperatorPlugin) and ( isProperty tmOP #colorMappingOperator_nextOperator )) do (
				tmOPplus = #(tmOP, tmOP.colorMappingOperator_id)
				insertItem tmOPplus tmOPs (tmOPs.count+1)
				tmOP = tmOP.colorMappingOperator_nextOperator
			) 
			tmOPs
		)
		catch (
			format ":: ❌ Error :: Corona Tone Mapping - Code CTM-1002 ::\n-- Getting all tone mapping operators and their IDs was not successful.\n%\n" (getCurrentException())
			undefined
		)	
	),
	
	-- Get the IDs of all tone mapping operators
	-- #(tmOP_1 ID, tmOP_2 ID, tmOP_3 ID, ...)
	fn GetAllTMOperatorsIDs = (
		try(
			tmOPs = #()
			tmOP = renderers.current.colorMap_pipeline 
			if (not ( isProperty tmOP #colorMappingOperator_nextOperator )) then ClearAllTMOperators()
			while ((tmOP != undefined ) and (classof tmOP != IdentityOperatorPlugin) and ( isProperty tmOP #colorMappingOperator_nextOperator )) do (
				insertItem tmOP.colorMappingOperator_id tmOPs (tmOPs.count+1)
				tmOP = tmOP.colorMappingOperator_nextOperator
			) 
			tmOPs
		)
		catch (
			format ":: ❌ Error :: Corona Tone Mapping - Code CTM-1003 ::\n-- Getting all tone mapping operators ID was not successful.\n%\n" (getCurrentException())
			undefined
		)
	),
	
	-- Get all tone mapping operators
	-- #(tmOP_1 , tmOP_2 , tmOP_3 , ...)
	fn GetAllTMOperators = (
		try(
			tmOPs = #()
			tmOP = renderers.current.colorMap_pipeline 
			if (not ( isProperty tmOP #colorMappingOperator_nextOperator )) then ClearAllTMOperators()
			while ((tmOP != undefined ) and (classof tmOP != IdentityOperatorPlugin) and ( isProperty tmOP #colorMappingOperator_nextOperator )) do (
				insertItem tmOP tmOPs (tmOPs.count+1)
				tmOP = tmOP.colorMappingOperator_nextOperator
			) 
			tmOPs
		)
		catch (
			format ":: ❌ Error :: Corona Tone Mapping - Code CTM-1004 ::\n-- Getting all tone mapping operators was not successful.\n%\n" (getCurrentException())
			undefined
		)
	),
	
	-- Generate a unique random ID that does not exist in the current operators' list
	fn GenerateID = (
		try (	
			tmOPsID = #()
			tmOPsID = GetAllTMOperatorsIDs()
			local ID = ( ( timeGetTime() * timeStamp() ) as integer )
			while ((findItem tmOPsID ID) != 0) do (ID = (( timeGetTime() * timeStamp() ) as integer ))
			ID
		)
		catch (
			format ":: ❌ Error :: Corona Tone Mapping - Code CTM-1005 ::\n-- Generating a unique random ID was not successful.\n%\n" (getCurrentException())
			undefined
		)
	),
	
	-- Get operators' class using its place on tone mapping list
	fn GetTMOperatorsClass ID:1 = (
		try (	
			if ID == unsupplied then ID = 1
			intID = ID as integer
			tmOPs = #()
			tmOPs = GetAllTMOperators()
			if tmOPs.count != 0 then
			(
				-- setting ID to a specific number if it is out of range
				if (intID > tmOPs.count) then intID = tmOPs.count
				if (intID <= 0) then intID = 1
				classof tmOPs[intID]
			)
			else (
				format ":: ❌ Error :: Corona Tone Mapping - Code CTM-1006 ::\n-- There are no operators in the list.\n" 
				undefined
			)
		)
		catch (
			format ":: ❌ Error :: Corona Tone Mapping - Code CTM-1001 ::\n-- Getting the tone mapping operator class was not successful.\n%\n" (getCurrentException())
			undefined
		)
	),
	
	-- Get operators' using its place on tone mapping list
	fn GetTMOperators ID:1 = (
		try (	
			if ID == unsupplied then ID = 1
			intID = ID as integer
			tmOPs = #()
			tmOPs = GetAllTMOperators()
			if tmOPs.count != 0 then
			(
				-- setting ID to a specific number if it is out of range
				if (intID > tmOPs.count) then intID = tmOPs.count
				if (intID <= 0) then intID = 1
				tmOPs[intID]
			)
			else (
				format ":: ❌ Error :: Corona Tone Mapping - Code CTM-1007 ::\n-- There are no operators in the list.\n" 
				undefined
			)
		)
		catch (
			format ":: ❌ Error :: Corona Tone Mapping - Code CTM-1001 ::\n-- Getting the tone mapping operator using id was not successful.\n%\n" (getCurrentException())
			undefined
		)
	),
	
	-- Specify whether the operators' list is empty or not (true or false)
	fn IsTMEmpy = (
		try (
			tmOPs = #()
			tmOPs = GetAllTMOperators()
			if tmOPs.count != 0 then false
			else true
		)
		catch (
			format ":: ❌ Error :: Corona Tone Mapping - Code CTM-1008 ::\n-- Specify whether the operators' list is empty or not, was not successful.\n%\n" (getCurrentException())
			undefined
		)
	),
	
	-- Delete last operator
	fn DelLastTMOperators = (
		try (
			LtmOP = renderers.current.colorMap_pipeline.colorMappingOperator_nextOperator 
			renderers.current.colorMap_pipeline = LtmOP
		)
		catch (
				format ":: ❌ Error :: Corona Tone Mapping - Code CTM-1009 ::\n-- Deleting the tone mapping operator at the bottom of the list was not successful.\n%\n" (getCurrentException())
				undefined
		)
	),
	
	-- Add operator as last one
	fn AddTMOperatorsLast tmOPs =
	(
		try (
			-- tmOps is array and it can be setup operators with or without it parameters
			-- example tmOPs: #(ContrastOperatorPlugin colorMappingOperator_contrast:0.6, AcesOtOperatorPlugin colorMappingOperator_opacity:0.4)
			-- this example will create two operators
			if tmOPs == unsupplied then tmOPs = #()
			for tmOP in tmOPs do
			(
				tmOP.colorMappingOperator_id = GenerateID() 
				tmOP.colorMappingOperator_enabled = true
				tmOP.colorMappingOperator_nextOperator = renderers.current.colorMap_pipeline
				renderers.current.colorMap_pipeline = tmOP
			)
		)
		catch (
			format ":: ❌ Error :: Corona Tone Mapping - Code CTM-1010 ::\n-- Adding the tone mapping operator at the bottom of the list was not successful.\n%\n" (getCurrentException())
			undefined
		)
	),
	
	-- Add operator to a specific place on the list
	fn AddTMOperatorsOnSpot tmOPs ID:1 =
	(
		try (	
			-- tmOps is array and it can be setup operators with or without it parameters
			-- example tmOPs: #(ContrastOperatorPlugin colorMappingOperator_contrast:0.6, AcesOtOperatorPlugin colorMappingOperator_opacity:0.4)
			-- this example will create two operators on the spot that id specify
			-- id is the position that operators will be adding
			AlltmOPs = #()
			RevAlltmOPs = #()
			if ( ( ID == unsupplied ) or ( ID < 1 ) ) then ID = 1
			if tmOPs == unsupplied then tmOPs = #()

			AlltmOPs = GetAllTMOperators()
			if ID > AlltmOPs.count then ID = AlltmOPs.count
			for newTMIdx = tmOPs.count to 1 by -1 do
			(
				tmOPs[newTMIdx].colorMappingOperator_id = GenerateID() 
				tmOPs[newTMIdx].colorMappingOperator_enabled = true
				insertItem tmOPs[newTMIdx] AlltmOPs ID
			)
			RevAlltmOPs = for idx = AlltmOPs.count to 1 by -1 collect AlltmOPs[idx]
			
			ClearAllTMOperators()
			
			for tmOP in RevAlltmOPs do 	
			(
				tmOP.colorMappingOperator_nextOperator = renderers.current.colorMap_pipeline
				renderers.current.colorMap_pipeline = tmOP
			)
		)
		catch (
			format ":: ❌ Error :: Corona Tone Mapping - Code CTM-1011 ::\n-- Adding the tone mapping operators using id was not successful.\n%\n" (getCurrentException())
			undefined
		)
	),
	
	-- Delete operator to a specific place on the list
	fn DelTMOperatorsOnSpot ID:1 =
	(
		try (
			-- id is the position that operators will be deleted
			-- id must be an integer
			AlltmOPs = #()
			RevAlltmOPs = #()
			if ( ( ID == unsupplied ) or ( ID < 1 ) ) then ID = 1

			AlltmOPs = GetAllTMOperators()
			if ID > AlltmOPs.count then ID = AlltmOPs.count
			
			deleteItem AlltmOPs ID

			RevAlltmOPs = for idx = AlltmOPs.count to 1 by -1 collect AlltmOPs[idx]
			
			ClearAllTMOperators()
			
			for tmOP in RevAlltmOPs do 	
			(
				tmOP.colorMappingOperator_nextOperator = renderers.current.colorMap_pipeline
				renderers.current.colorMap_pipeline = tmOP
			)
		)
		catch (
			format ":: ❌ Error :: Corona Tone Mapping - Code CTM-1012 ::\n-- Deleting the tone mapping operator using id was not successful.\n%\n" (getCurrentException())
			undefined
		)
	)	
)
