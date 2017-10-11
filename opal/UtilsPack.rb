module UtilsPack

	def after(delay, &block)
		$$[:setTimeout].call(block, delay * 1000)
	end

	def js_new(func, *args, &block)
		args.insert(0, `this`)
		args << block if block

		Native(`new (#{func}.bind.apply(#{func}, #{args}))`)
	end

end