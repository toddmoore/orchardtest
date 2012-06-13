class Base 
	attr: "data-role"
	globalWidth: ($ window).width()
	constructor: ->
		false
	pageHasAttr: ->
		if typeof @role == "object"
			ok = false
			for role in @role
				@el = ($ "["+@attr+"="+role+"]")
				if @el.length > 0
					ok = true
			if ok
				return true
		else
			@el = ($ "["+@attr+"="+@role+"]")
			if @el.length > 0
				return true	


class OrchardTreeMenu extends Base
	role: "tree-menu"
	tpl: ($ "<em>")
	childrenClass: "more"
	openClass: "open"
	closedClass: "closed"

	constructor: ->
		super
		if @pageHasAttr()
			@createMenu ($ menu) for menu in @el

	createMenu: (el) ->
		@processNode ($ listItem) for listItem in el.find("li")
	
			
	processNode: (li) ->				
		length = li.children("ul").length


		clickedParent = (e) =>
			e.preventDefault()
			e.stopPropagation()
			if li.hasClass(@openClass)
				li.children("ul").css("display", "none")
				@changeClass li, @closedClass, @openClass
			else
				li.children("ul").css("display", "block")
				@changeClass li, @openClass, @closedClass


		clickedChild = (e) =>
			e.stopPropagation()
			

		if length
			li.prepend(@tpl.clone().addClass(
				@childrenClass + " " +@closedClass
				).text("+"))
			li.click(clickedParent)

		else
			li.prepend(@tpl.clone())
			li.click(clickedChild)

		

	changeClass: (li, add, remove) ->
		if add == @openClass
			t = "-"
		else 
			t = "+"

		li.addClass(add).removeClass(remove)
		li.find("> em").addClass(add).removeClass(remove).text(t)


class Application
	constructor: ->
		@treeMenu = new OrchardTreeMenu

$ ->
	app = new Application
