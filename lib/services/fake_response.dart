
class FakeResponse {

  String auth() {
    return '{"data":{"uid":"999999","name":"Test User","email":"testuser@novomundo.com.br","token":"user_token_999999","menu":{"tipo":"menu","menus":[{"id":44,"menu":"Vendas"}]},"apps":{"android":{"version":"8","app_url":"https://play.google.com/store/apps/details?id=com.novomundo.labs.iceberg"},"ios":{"version":"1.1","app_url":"https://play.google.com/store/apps/details?id=com.novomundo.labs.iceberg"}}}}';
  }

  String authFailed() {
    return '{"code":3,"error":"Ldap error","msg":"Credenciais inválidas, tente novamente"}';
  }

  String indicador() {
    return '{"tipo":"indicador","nivel_acesso":3,"indicadores":[{"titulo":"Vendas","id":1,"venda":100,"meta":200,"perc_meta":50.0,"perc_cresc":93.3,"projecao":200,"proj_crescimento":70.86,"proj_perc_meta":49.75,"tipo_grafico":"progressbar","detalhe":1},{"titulo":"LD","id":2,"venda":100,"meta":100,"perc_meta":100.0,"perc_cresc":-10.5,"tipo_grafico":"progressbar","detalhe":1},{"titulo":"FL","id":3,"venda":100,"meta":200,"perc_meta":50.0,"perc_cresc":50.7,"tipo_grafico":"progressbar","detalhe":1},{"titulo":"BG","id":4,"venda":100,"meta":50,"perc_meta":200.0,"perc_cresc":-16.4,"tipo_grafico":"progressbar","detalhe":1},{"titulo":"PM","id":6,"venda":100,"meta":100,"perc_meta":100.0,"perc_cresc":60.7,"tipo_grafico":"progressbar","detalhe":1},{"titulo":"LB","id":7,"venda":10.65,"meta":10.65,"perc_meta":10.65,"percent":"1","perc_cresc":106.8,"tipo_grafico":"progressbar","detalhe":1},{"titulo":"Frete","id":8,"tipo_grafico":"progressbar","detalhe":1,"venda":100,"meta":200,"perc_meta":50.0,"perc_cresc":-16},{"titulo":"Serviços","id":9,"venda":10.0,"meta":10.0,"perc_meta":10.0,"perc_cresc":10.4,"tipo_grafico":"progressbar","detalhe":1,"percent":"1"},{"titulo":"Cursos","id":10,"venda":44,"meta":22,"perc_meta":200.0,"perc_cresc":200.7,"tipo_grafico":"progressbar","detalhe":1}]}';
  }

  String detalhe(int detalhe) {
    
    switch(detalhe) {
      case 1:
        return '{"tipo":"indicador","nivel_acesso":3,"id":1,"tipo_grafico":"pizza","detalhe":2,"dados":[{"titulo":"BRANCA","id":1,"venda":100,"meta":100,"perc_meta":100.0,"perc_cresc":19.2},{"titulo":"MOVEIS - DORMITORIOS","id":2,"venda":200,"meta":400,"perc_meta":50.0,"perc_cresc":7},{"titulo":"UD/PORTATEIS","id":3,"venda":1000,"meta":500,"perc_meta":50.0,"perc_cresc":43.6},{"titulo":"TELEFONIA","id":4,"venda":50,"meta":200,"perc_meta":25.0,"perc_cresc":9.2},{"titulo":"INFORMATICA","id":5,"venda":10,"meta":20,"perc_meta":200.0,"perc_cresc":2},{"titulo":"MARROM","id":6,"venda":1000,"meta":3000,"perc_meta":300.0,"perc_cresc":15.4},{"titulo":"MOVEIS - SALA E COZINHA","id":7,"venda":100,"meta":100,"perc_meta":100.0,"perc_cresc":-9.9},{"titulo":"BRINDES","id":9,"venda":150,"meta":300,"perc_meta":50.0,"perc_cresc":10}]}';

      case 2:
        return '{"tipo":"indicador","nivel_acesso":3,"id":1,"tipo_grafico":"lista","detalhe":0,"dados":[{"titulo":"Loja 1","id":1,"venda":100,"meta":300,"perc_meta":33.3,"perc_cresc":48.7},{"titulo":"Loja 2","id":2,"venda":500,"meta":500,"perc_meta":100.0,"perc_cresc":200.2},{"titulo":"Loja 3","id":3,"venda":250,"meta":500,"perc_meta":50.0,"perc_cresc":-86.1},{"titulo":"Loja 4","id":4,"venda":50,"meta":100,"perc_meta":200.0,"perc_cresc":-10.7},{"titulo":"Loja 5","id":5,"venda":1000,"meta":1500,"perc_meta":150.0,"perc_cresc":170.1},{"titulo":"Loja 6","id":6,"venda":100,"meta":70,"perc_meta":70.0,"perc_cresc":5.6},{"titulo":"Loja 7","id":7,"venda":10000,"meta":5000,"perc_meta":50.0,"perc_cresc":-8.3}]}';

      default:
        return '';    
    }
  }

  String filtros() {
    return '{"tipo":"filtros","filtros":[{"id":2,"nome":"Filtro 1"},{"id":4,"nome":"Filtro 2"},{"id":12,"nome":"Filtro 3"},{"id":18,"nome":"Filtro 4"},{"id":19,"nome":"Filtro 5"},{"id":20,"nome":"Filtro 6"},{"id":283,"nome":"Filtro 7"},{"id":324,"nome":"Filtro 8"},{"id":421,"nome":"Filtro 9"},{"id":481,"nome":"Filtro 10"},{"id":482,"nome":"Filtro 11"},{"id":507,"nome":"Filtro 12"},{"id":641,"nome":"Filtro 13"},{"id":721,"nome":"Filtro 14"},{"id":722,"nome":"Filtro 15"}]}';
  }

  String departamentos() {
    return '{"tipo":"departamentos","departamentos":[{"id_departamento":1,"desc_departamento":"BRANCA"},{"id_departamento":9,"desc_departamento":"BRINDES"},{"id_departamento":8,"desc_departamento":"ESPORTE E LAZER"},{"id_departamento":5,"desc_departamento":"INFORMATICA"},{"id_departamento":6,"desc_departamento":"MARROM"},{"id_departamento":2,"desc_departamento":"MOVEIS - DORMITORIOS"},{"id_departamento":7,"desc_departamento":"MOVEIS - SALA E COZINHA"},{"id_departamento":4,"desc_departamento":"TELEFONIA"},{"id_departamento":3,"desc_departamento":"UD/PORTATEIS"}]}';
  }
}