module NextLMS
  class MarkdownParser < Redcarpet::Render::Safe
    def block_code(code, language)
      Pygments.highlight(code, lexer: language)
    end
  end
end