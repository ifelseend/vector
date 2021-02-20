package metadata

import "strconv"

remap: {
	#Error: {
		code:                >=100 & <1000 & int
		anchor:              "\(code)"
		title:               string
		description:         string
		how_to_fix?:         string
		fail_safety_related: bool | *false

		if fail_safety_related {
			blurb: """
				VRL is a [fail-safe](\(urls.vrl_fail_safety)) language, which means that it requires that all possible
				runtime errors be handled. This provides important [safety guarantees](\(urls.vrl_safety)) and helps to
				ensure that VRL programs run reliably when deployed.
				"""
		}
	}

	errors: [Code=string]: #Error & {
		code: strconv.ParseInt(Code, 0, 16)
	}
}

remap: errors: {
	"100": {
		title:       "Unhandled root runtime error"
		description: """
			A root expression is fallible but its [runtime error](\(urls.vrl_runtime_errors)) isn't handled in the VRL
			program.
			"""
		how_to_fix: """
			[Handle](\(urls.vrl_error_handling)) the runtime error by [assigning](\(urls.vrl_error_handling_assigning)),
			[coalescing](\(urls.vrl_error_handling_coalescing)), or [raising](\(urls.vrl_error_handling_raising)) the
			error.
			"""

		fail_safety_related: true
	}

	"101": {
		title: "Malformed regular expression literal"
		description: """
			A [regex literal](\(urls.vrl_expressions)#\(remap.literals.regular_expression.anchor)) is malformed and thus
			doesn't result in a valid regular expression.
			"""
		how_to_fix: """
			If you're sure that you need to use a regular expression, use the [Rust regex tester](\(urls.regex_tester))
			to test and correct your regex. Keep in mind, though, that VRL has a series of [`parse_*`
			functions](\(urls.vrl_functions)#parsing) that may serve your use case directly, which could enable you to
			avoid using a regular expression altogether.

			If you're working with a commonly used log format and don't see a parsing function for it, you can submit a
			[request](\(urls.new_feature_request)) to the Vector team.
			"""
	}
}
