struct ToneParams {
    frequency: (UInt, UInt)
    adsr: @wasm4.ADSR
    volume: @wasm4.ADSRVolume
    channel: @wasm4.ToneFlag
}

fn play_tone(params: ToneParams) -> Unit {
    @wasm4.tone(params.frequency, params.adsr, params.volume, params.channel);
}

fn setup_tone_params() -> Array[ToneParams] {
    let adsr = @wasm4.ADSR::new(attack=0, decay=0,30, release=0);
    let volume = @wasm4.ADSRVolume::new(100,peak=100);

    let channel1 = @wasm4.ToneFlag::new(
        channel = @wasm4.ToneChannel::Triangle,
        mode = @wasm4.ToneMode::Duty_1_4,
        pan = @wasm4.TonePan::Left
    );

    let channel2 = @wasm4.ToneFlag::new(
        channel = @wasm4.ToneChannel::Triangle,
        mode = @wasm4.ToneMode::Duty_1_2,
        pan = @wasm4.TonePan::Right
    );

    let channel3 = @wasm4.ToneFlag::new(
        channel = @wasm4.ToneChannel::Triangle,
        mode = @wasm4.ToneMode::Duty_1_2,
        pan = @wasm4.TonePan::Center
    );

    let tone1 = {
        frequency: (261, 523),
        adsr: adsr,
        volume: volume,
        channel: channel1
    };

    let tone2 = {
        frequency: (293, 587),
        adsr: adsr,
        volume: volume,
        channel: channel2
    };

    let tone3 = {
        frequency: (329, 659),
        adsr: adsr,
        volume: volume,
        channel: channel3
    };

    let tone4 = {
        frequency: (349, 698),
        adsr: adsr,
        volume: volume,
        channel: channel1
    };

    let tone5 =  {
        frequency: (392, 784),
        adsr: adsr,
        volume: volume,
        channel: channel2
    };

    let tone6 = {
        frequency: (440, 880),
        adsr: adsr,
        volume: volume,
        channel: channel3
    };

    let tone7 = {
        frequency: (493, 987),
        adsr: adsr,
        volume: volume,
        channel: channel1
    };

    let tone8 = {
        frequency: (523, 1046),
        adsr: adsr,
        volume: volume,
        channel: channel2
    };

    return [tone1, tone2, tone3, tone4, tone5, tone6, tone7, tone8];
}

let tones: Array[ToneParams] = setup_tone_params();

pub fn start() -> Unit {
    // 初始化音调参数
}

pub fn musicplay() -> Unit {
    let frame_counter :UInt64= @time_cnt.get_time();
		    // 每秒运行60次，假设每个音调播放0.5秒（30帧）
    let tone_duration :Int= 30;
    let index :Int64= ((frame_counter.to_int64() / tone_duration.to_int64()) % 8);
    // 根据frame_counter的值播放不同的音调
    let index=index.to_int();
    play_tone(tones[index])
}